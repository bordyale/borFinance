
import org.apache.ofbiz.entity.condition.EntityExpr
import org.apache.ofbiz.entity.condition.EntityFunction
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.condition.EntityFieldValue
import org.apache.ofbiz.entity.condition.EntityConditionList
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.GenericValue
import org.apache.ofbiz.entity.util.EntityUtil
import org.apache.ofbiz.base.util.UtilDateTime
import org.apache.ofbiz.base.util.UtilMisc
import org.apache.ofbiz.service.ServiceUtil

import java.sql.Timestamp
import java.math.BigDecimal
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.Locale
import java.util.Map
import java.text.DecimalFormatSymbols
//TO:DO check session locale
//Locale italian = new Locale("it", "IT", "EURO");
//Locale.setDefault(italian);
Locale customLocale = new Locale("it", "IT");
DecimalFormat df = new DecimalFormat("###.##");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
prodId = parameters.prodId
brokerId = parameters.brokerId
sectorId = parameters.sectorId

List filCond = []
if (prodId) {
	filCond.add(EntityCondition.makeCondition("prodId", EntityOperator.EQUALS, prodId))
}else{
	prodId=""
}
if (brokerId) {
	filCond.add(EntityCondition.makeCondition("brokerId", EntityOperator.EQUALS, brokerId))
}
if (sectorId) {
	filCond.add(EntityCondition.makeCondition("sectorId", EntityOperator.EQUALS, sectorId))
}

filCondAND = EntityCondition.makeCondition(filCond, EntityOperator.AND)
if(brokerId)
{
	pricesList = from("BfinPurchaseAvgPriceViewBroker").where(filCondAND).orderBy("prodName").cache(false).queryList()
}else{
	pricesList = from("BfinPurchaseAvgPriceView").where(filCondAND).orderBy("prodName").cache(false).queryList()
}



sectors = from("Enumeration").where("enumTypeId", "BFIN_SECTOR").orderBy("sequenceId").queryList()


List<HashMap<String,Object>> hashMaps = new ArrayList<HashMap<String,Object>>()
List<HashMap<String,Object>> prodsNotInPortfolio = new ArrayList<HashMap<String,Object>>()
List<HashMap<String,Object>> sectorsList = new ArrayList<HashMap<String,Object>>()
BigDecimal totMktValue = BigDecimal.ZERO
BigDecimal totPurchValue = BigDecimal.ZERO
BigDecimal totDivUSD = BigDecimal.ZERO
Map<String,Object> se = new HashMap<String,Object>()
for (GenericValue entry: pricesList){

	Map<String,Object> e = new HashMap<String,Object>()

	String sectorId = entry.get("sectorId")
	e.put("prodId",entry.get("prodId"))
	e.put("prodSym",entry.get("prodSym"))
	e.put("prodName",entry.get("prodName"))
	e.put("sectorId",sectorId)
	String currentUOMId =entry.get("currencyUomId")
	e.put("currencyUomId",currentUOMId)
	//se.put("sectorId",sectorId)
	BigDecimal qtySum =(BigDecimal)entry.get("quantitySum")
	//populate not in portfolio products
	if (qtySum==null){
		prodsNotInPortfolio.add(e)
		continue
	}


	e.put("quantitySum",qtySum)
	BigDecimal avgPurchPrice =(BigDecimal)entry.get("avgPurchPrice").setScale(3,RoundingMode.HALF_UP)
	e.put("avgPurchPrice",new DecimalFormat(
			"###.##",
			DecimalFormatSymbols.getInstance(customLocale)).format(avgPurchPrice))
	prodId = entry.get("prodId")
	//convert Purchased Avg Price for Sum
	BigDecimal avgPurchPriceStock =avgPurchPrice.multiply(qtySum)
	if (currentUOMId && !"USD".equals(currentUOMId)) {
		serviceResults = runService('convertUom',
				[uomId : currentUOMId, uomIdTo : "USD", originalValue : avgPurchPriceStock])
		if (ServiceUtil.isError(serviceResults)) {
			request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResults))
			return
		} else {
			converted = serviceResults.convertedValue
			totPurchValue=totPurchValue.add(converted)
		}
	}else{
		totPurchValue=totPurchValue.add(avgPurchPriceStock)
	}
	//extract Last Dividend
	BigDecimal forwardAnnualDiv = BigDecimal.ZERO
	dividend = from("BfinDividend").where("prodId",prodId).orderBy("date DESC").cache(false).queryFirst()
	if (dividend){
		BigDecimal amount =dividend.amount
		e.put("lastDividend",amount)
		e.put("lastDividendDate",sdf.format(dividend.date))
		String divFreqId = divFreqId = dividend.divFreqId
		if (divFreqId !=null && divFreqId.equals("QUAR")){
			forwardAnnualDiv = amount.divide(new BigDecimal(3),3,RoundingMode.HALF_UP).multiply(new BigDecimal(12))
		}
		if (divFreqId !=null && divFreqId.equals("SEMES")){
			forwardAnnualDiv = amount.divide(new BigDecimal(6),3,RoundingMode.HALF_UP).multiply(new BigDecimal(12))
		}
		if (divFreqId !=null && divFreqId.equals("ANN")){
			forwardAnnualDiv = amount
		}
		if (divFreqId !=null && divFreqId.equals("MON")){
			forwardAnnualDiv = amount.multiply(new BigDecimal(12))
		}
		//convert Dividend
		if (currentUOMId && !"USD".equals(currentUOMId)) {
			serviceResults = runService('convertUom',
					[uomId : currentUOMId, uomIdTo : "USD", originalValue : forwardAnnualDiv])
			if (ServiceUtil.isError(serviceResults)) {
				request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResults))
				return
			} else {
				convertedForwartAnnDiv = serviceResults.convertedValue
				totDivUSD=totDivUSD.add(convertedForwartAnnDiv.multiply(qtySum))
			}
		}else{
			totDivUSD=totDivUSD.add(forwardAnnualDiv.multiply(qtySum))
		}
	}
	//extract Last Price
	price = from("BfinPrice").where("prodId",prodId).orderBy("date DESC").cache(false).queryFirst()
	if (price){
		BigDecimal priceNow = price.price
		e.put("lastMktPrice",new DecimalFormat(
				"###.##",
				DecimalFormatSymbols.getInstance(customLocale)).format(priceNow))
		e.put("lastMktPriceDate",sdf.format(price.date))
		BigDecimal mktValue =qtySum.multiply(priceNow).setScale(3,RoundingMode.HALF_UP)
		e.put("mktValue",new DecimalFormat(
				"###",
				DecimalFormatSymbols.getInstance(customLocale)).format(mktValue))
		//market Gain
		BigDecimal gain = priceNow.subtract(avgPurchPrice)
		e.put("mktGainPerc",gain.divide(avgPurchPrice,3,RoundingMode.HALF_UP).multiply(new BigDecimal(100)))


		//convert Market Value
		if (currentUOMId && !"USD".equals(currentUOMId)) {
			serviceResults = runService('convertUom',
					[uomId : currentUOMId, uomIdTo : "USD", originalValue : mktValue])
			if (ServiceUtil.isError(serviceResults)) {
				request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResults))
				return
			} else {
				BigDecimal convertedValue = serviceResults.convertedValue
				e.put("mktValueConverted",new DecimalFormat(
						"###",
						DecimalFormatSymbols.getInstance(customLocale)).format(convertedValue))
				e.put("mktValueConvertedBigDec",convertedValue)

				UtilMisc.addToBigDecimalInMap(se, sectorId, convertedValue)
				totMktValue= totMktValue.add(convertedValue)

			}
		}else{
			e.put("mktValueConverted",new DecimalFormat(
					"###",
					DecimalFormatSymbols.getInstance(customLocale)).format(mktValue))
			e.put("mktValueConvertedBigDec",mktValue)
			UtilMisc.addToBigDecimalInMap(se, sectorId, mktValue)
			totMktValue= totMktValue.add(mktValue)
		}

		//e.put("percentage",mktValue.divide(totMktValue,3,RoundingMode.HALF_UP))
		//current Yield
		BigDecimal curryield = forwardAnnualDiv.divide(priceNow,6,RoundingMode.HALF_UP).multiply(new BigDecimal(100))
		e.put("currYield",curryield)
	}

	hashMaps.add(e)
}
for (e in hashMaps){
	BigDecimal mktValueConverted = (BigDecimal)e.mktValueConvertedBigDec
	if (totMktValue && mktValueConverted) {
		e.put("percentage", mktValueConverted.divide(totMktValue,3,RoundingMode.HALF_UP).multiply(new BigDecimal(100)))
		e.put("percString",df.format(e.("percentage")))
	}
}





//SECTORS
for (e in se){
	Map<String,Object> sector  = new HashMap<String,Object>()
	sector.put("sectorId",e.key)
	sector.put("mktValue",new DecimalFormat(
			"###",
			DecimalFormatSymbols.getInstance(customLocale)).format(e.value))
	sector.put("percentage",(BigDecimal)e.value.divide(totMktValue,3,RoundingMode.HALF_UP).multiply(new BigDecimal(100)))

	sectorsList.add(sector)
}
Map<String,Object> sector  = new HashMap<String,Object>()
//total Purchased Avg Value


sector  = new HashMap<String,Object>()
if (totPurchValue){
	sector.put("sectorId","TOT PURCHASED PRICE (USD)")
	sector.put("mktValue",new DecimalFormat(
			"###",
			DecimalFormatSymbols.getInstance(customLocale)).format(totPurchValue))
	sectorsList.add(sector)
}
//total Market Value
sector  = new HashMap<String,Object>()
if (totMktValue){
	sector.put("sectorId","TOT PORT VALUE (USD)")
	sector.put("mktValue",new DecimalFormat(
			"###",
			DecimalFormatSymbols.getInstance(customLocale)).format(totMktValue))
	sector.put("percentage",totMktValue.divide(totMktValue,3,RoundingMode.HALF_UP).multiply(new BigDecimal(100)))
	sectorsList.add(sector)
}
//total Market Gain
sector  = new HashMap<String,Object>()
if (totMktValue){
	BigDecimal marketGain =totMktValue.subtract(totPurchValue)
	sector.put("sectorId","MARKET GAIN")
	sector.put("mktValue",new DecimalFormat(
			"###",
			DecimalFormatSymbols.getInstance(customLocale)).format(marketGain))
	sector.put("percentage",marketGain.divide(totPurchValue,3,RoundingMode.HALF_UP).multiply(new BigDecimal(100)))
	sectorsList.add(sector)
}
//total Dividend
sector  = new HashMap<String,Object>()
if (totDivUSD){
	sector.put("sectorId","TOT DIV ANN FORWARD VALUE (USD)")
	sector.put("mktValue",new DecimalFormat(
			"###",
			DecimalFormatSymbols.getInstance(customLocale)).format(totDivUSD))
	sector.put("percentage",totDivUSD.divide(totMktValue,4,RoundingMode.DOWN).multiply(new BigDecimal(100)))
	sectorsList.add(sector)
}

//portfolio Size
sector  = new HashMap<String,Object>()

sector.put("sectorId","# OF STOCK IN PORTFOLIO")
sector.put("mktValue",hashMaps.size())
sectorsList.add(sector)



context.reportList = hashMaps;
context.sectorList = sectorsList;
context.prodsNotInPortfolio = prodsNotInPortfolio;

// brokers
brokers = from("Enumeration").where("enumTypeId", "BFIN_BROKER").orderBy("sequenceId").queryList()
context.brokers = brokers
context.sectors = sectors





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


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
prodId = parameters.prodId

List filCond = []
if (prodId) {
	filCond.add(EntityCondition.makeCondition("prodId", EntityOperator.EQUALS, prodId))
}

filCondAND = EntityCondition.makeCondition(filCond, EntityOperator.AND)

pricesList = from("BfinPurchaseAvgPriceView").where(filCondAND).orderBy("prodName").cache(false).queryList()


sectors = from("Enumeration").where("enumTypeId", "BFIN_SECTOR").orderBy("sequenceId").queryList()


List<HashMap<String,Object>> hashMaps = new ArrayList<HashMap<String,Object>>()
List<HashMap<String,Object>> sectorsList = new ArrayList<HashMap<String,Object>>()
BigDecimal totMktValue = BigDecimal.ZERO
Map<String,Object> se = new HashMap<String,Object>()
for (GenericValue entry: pricesList){

	Map<String,Object> e = new HashMap<String,Object>()

	String sectorId = entry.get("sectorId")
	e.put("prodSym",entry.get("prodSym"))
	e.put("prodName",entry.get("prodName"))
	e.put("sectorId",sectorId)
	//se.put("sectorId",sectorId)
	BigDecimal qtySum =(BigDecimal)entry.get("quantitySum")
	e.put("quantitySum",qtySum)
	e.put("avgPurchPrice",(BigDecimal)entry.get("avgPurchPrice").setScale(3,RoundingMode.HALF_UP))
	prodId = entry.get("prodId")
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
		if (divFreqId !=null && divFreqId.equals("ANN")){
			forwardAnnualDiv = amount
		}
		if (divFreqId !=null && divFreqId.equals("MON")){
			forwardAnnualDiv = amount.multiply(new BigDecimal(12))
		}
	}
	//extract Last Price
	price = from("BfinPrice").where("prodId",prodId).orderBy("date DESC").cache(false).queryFirst()
	if (price){
		BigDecimal priceNow = price.price
		e.put("lastMktPrice",priceNow)
		e.put("lastMktPriceDate",sdf.format(price.date))
		BigDecimal mktValue =qtySum.multiply(priceNow).setScale(3,RoundingMode.HALF_UP)
		e.put("mktValue",mktValue)
		//convert currency
		String currentUOMId =entry.get("currencyUomId")

		e.put("currencyUomId",currentUOMId)
		if (currentUOMId && !"USD".equals(currentUOMId)) {
			serviceResults = runService('convertUom',
					[uomId : currentUOMId, uomIdTo : "USD", originalValue : mktValue])
			if (ServiceUtil.isError(serviceResults)) {
				request.setAttribute("_ERROR_MESSAGE_", ServiceUtil.getErrorMessage(serviceResults))
				return
			} else {
				convertedValue = serviceResults.convertedValue
				
					e.put("mktValueConverted",convertedValue)
					UtilMisc.addToBigDecimalInMap(se, sectorId, convertedValue)
					totMktValue= totMktValue.add(convertedValue)
				
			}
		}else{
			e.put("mktValueConverted",mktValue)
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
	BigDecimal mktValueConverted = (BigDecimal)e.mktValueConverted
	if (totMktValue && mktValueConverted) {
		e.put("percentage", mktValueConverted.divide(totMktValue,3,RoundingMode.HALF_UP).multiply(new BigDecimal(100)))

		}
}





//SECTORS
for (e in se){
	Map<String,Object> sector  = new HashMap<String,Object>()
	sector.put("sectorId",e.key)
	sector.put("mktValue",e.value)
	sector.put("percentage",(BigDecimal)e.value.divide(totMktValue,3,RoundingMode.HALF_UP))

	sectorsList.add(sector)
}
//total Market Value
Map<String,Object> sector  = new HashMap<String,Object>()
if (totMktValue){
	sector.put("sectorId","TOT PORT VALUE (USD)")
	sector.put("mktValue",totMktValue)
	sector.put("percentage",totMktValue.divide(totMktValue,3,RoundingMode.HALF_UP))
	sectorsList.add(sector)
}

context.reportList = hashMaps;
context.sectorList = sectorsList;
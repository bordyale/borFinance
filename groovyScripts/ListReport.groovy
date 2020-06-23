
import org.apache.ofbiz.entity.condition.EntityExpr
import org.apache.ofbiz.entity.condition.EntityFunction
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.condition.EntityFieldValue
import org.apache.ofbiz.entity.condition.EntityConditionList
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.GenericValue
import org.apache.ofbiz.entity.util.EntityUtil
import org.apache.ofbiz.base.util.UtilDateTime

import java.sql.Timestamp
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.Locale


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
prodId = parameters.prodId

List filCond = []
if (prodId) {
	filCond.add(EntityCondition.makeCondition("prodId", EntityOperator.EQUALS, prodId))
}

filCondAND = EntityCondition.makeCondition(filCond, EntityOperator.AND)

pricesList = from("BfinPurchaseAvgPriceView").where(filCondAND).orderBy("prodName").cache(false).queryList()





List<HashMap<String,Object>> hashMaps = new ArrayList<HashMap<String,Object>>()


for (GenericValue entry: pricesList){
	Map<String,Object> e = new HashMap<String,Object>()
	e.put("prodSym",entry.get("prodSym"))
	e.put("prodName",entry.get("prodName"))
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
		e.put("mktValue",qtySum.multiply(priceNow).setScale(3,RoundingMode.HALF_UP))
		//current Yield
		BigDecimal curryield = forwardAnnualDiv.divide(priceNow,4,RoundingMode.HALF_UP).multiply(new BigDecimal(100))
		e.put("currYield",curryield)
	}

	hashMaps.add(e)
}

context.reportList = hashMaps;
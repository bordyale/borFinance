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

// currencies and shopping cart currency
context.currencies = from("Uom").where("uomTypeId", "CURRENCY_MEASURE").cache(true).queryList()
context.currencyUomId = "USD"





prodId = parameters.prodId

List filCond = []
if (prodId) {
	filCond.add(EntityCondition.makeCondition("prodId", EntityOperator.EQUALS, prodId))
}

filCondAND = EntityCondition.makeCondition(filCond, EntityOperator.AND)

purchaseList = from("BfinProdPurchView").where(filCondAND).orderBy("prodName").cache(false).queryList()



context.purchaseList = purchaseList;
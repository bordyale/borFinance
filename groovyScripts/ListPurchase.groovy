// currencies and shopping cart currency
context.currencies = from("Uom").where("uomTypeId", "CURRENCY_MEASURE").cache(true).queryList()
context.currencyUomId = "USD"
/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/

package org.apache.ofbiz.borfinance;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilDateTime;
import org.apache.ofbiz.base.util.UtilMisc;
import org.apache.ofbiz.base.util.UtilNumber;
import org.apache.ofbiz.base.util.UtilProperties;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.service.GenericServiceException;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.entity.condition.EntityCondition;
import org.apache.ofbiz.entity.condition.EntityExpr;
import org.apache.ofbiz.entity.condition.EntityOperator;
import org.apache.ofbiz.entity.util.EntityQuery;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.LocalDispatcher;
import org.apache.ofbiz.service.ModelService;
import org.apache.ofbiz.service.ServiceUtil;
import org.json.JSONObject;
import org.json.JSONException;

/**
 * Services for Agreement (Accounting)
 */

public class BorFinanceServices {

	public static final String module = BorFinanceServices.class.getName();

	public static final String resource = "BorFinanceUiLabels";
	private static final String USER_AGENT = "Mozilla/5.0";

	private static final String[] apikey = { "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "TCWC4KTESJIY8UL5", "TCWC4KTESJIY8UL5",
			"TCWC4KTESJIY8UL5", "TCWC4KTESJIY8UL5", "TCWC4KTESJIY8UL5", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "NRXCKC71QSMJQZYA",
			"NRXCKC71QSMJQZYA", "NRXCKC71QSMJQZYA", "NRXCKC71QSMJQZYA", "NRXCKC71QSMJQZYA" };

	public static Map<String, Object> populateDividendTable(DispatchContext ctx, Map<String, Object> context) {
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		String errMsg = null;
		Map<String, Object> result = ServiceUtil.returnSuccess();

		GenericValue userLogin = (GenericValue) context.get("userLogin");

		// If Sunday of Monday dont check previous day
		Calendar d = Calendar.getInstance();
		Date today = new Date();
		d.setTime(today);
		int dayOfWeek = d.get(Calendar.DAY_OF_WEEK);

		if (dayOfWeek == 1 || dayOfWeek == 2) {
			Debug.logWarning("ON DAY: " + new SimpleDateFormat("EE").format(today) + " DON'T EXECUTE populateDividendTable()", module);
			return result;
		}

		long startTime = System.currentTimeMillis();
		try {
			List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("productType", EntityOperator.EQUALS, "STOCK"));
			EntityCondition cond = EntityCondition.makeCondition(exprs, EntityOperator.AND);
			List<GenericValue> conditions = EntityQuery.use(delegator).from("BfinProduct").where(cond).orderBy("prodId ASC").queryList();

			int i = 0;
			int apiindex = 0;
			boolean reset = false;

			for (GenericValue stock : conditions) {
				String symbol = (String) stock.get("prodSym");
				String prodId = (String) stock.get("prodId");
				String divFreqId = (String) stock.get("divFreqId");
				String skipApi = (String) stock.get("skipApi");

				if (skipApi != null && "Y".equals(skipApi)) {
					continue;
				}

				if (i != 0 && i % 4 == 0) {
					break;
				}
				// To avoid ask API if not necessary
				GenericValue lastDividendStored = EntityQuery.use(delegator).from("BfinDividend").where("prodId", prodId).cache().orderBy("date DESC").queryFirst();
				if (lastDividendStored != null) {
					Date lastDividendStoredDateCheck = (Date) lastDividendStored.get("dateLastCheckForPopulation");
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					int backDayytocheck = -1;
					c.add(Calendar.DATE, backDayytocheck);
					if (c.getTime().compareTo(lastDividendStoredDateCheck) < 0) {
						Debug.logWarning(symbol + " " + "LAST DIVIDEND ALREADY SAVED IN THE LAST " + backDayytocheck + " DAYS, SKiP API REQUEST", module);
						continue;
					}
				}
				i++;
				JSONObject resp = sendGet(symbol, apikey[5]);
				JSONObject arr;
				try {
					arr = resp.getJSONObject("Monthly Adjusted Time Series");
				} catch (JSONException e) {
					Debug.logWarning(e, module);
					Debug.logError(symbol + " " + i + " " + resp.toString(), module);
					Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
					errMsg = UtilProperties.getMessage(resource, "JSONExpection", messageMap, locale);
					return ServiceUtil.returnError(errMsg);
				}
				SortedMap<String, String> divMap = new TreeMap<String, String>(Collections.reverseOrder());
				Iterator it = arr.keys();
				while (it.hasNext()) {
					String key = (String) it.next();
					divMap.put(key, arr.getJSONObject(key).getString("7. dividend amount"));
				}
				// System.out.println(divMap.toString());

				boolean foundLastDiv = false;
				boolean growCheck = true;
				int growingDivYears = 0;
				BigDecimal prevYearDiv = BigDecimal.ZERO;
				// Map<String, Object> yearsMap = new HashMap<String, Object>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String lastClosePrice = arr.getJSONObject(divMap.firstKey()).getString("5. adjusted close");
				String lastClosePriceDateStr = divMap.firstKey();
				Date lastClosePriceDate = sdf.parse(lastClosePriceDateStr);
				// System.out.print("Last closed Price" + lastClosePrice);
				// SAVE LAST CLOSED PRICE
				GenericValue lastPriceStored = EntityQuery.use(delegator).from("BfinPrice").where("prodId", prodId).cache().orderBy("date DESC").queryFirst();
				if (lastPriceStored != null) {
					Date lastSavedDate = (Date) lastPriceStored.get("date");
					if (lastClosePriceDate.after(lastSavedDate)) {
						try {
							Map<String, Object> tmpResult = dispatcher.runSync("createBfinPrice",
									UtilMisc.<String, Object> toMap("userLogin", userLogin, "date", lastClosePriceDate, "price", lastClosePrice, "prodId", prodId));
						} catch (GenericServiceException e) {
							Debug.logError(e, module);
						}

					}

				} else {
					try {
						Map<String, Object> tmpResult = dispatcher.runSync("createBfinPrice",
								UtilMisc.<String, Object> toMap("userLogin", userLogin, "date", lastClosePriceDate, "price", lastClosePrice, "prodId", prodId));
					} catch (GenericServiceException e) {
						Debug.logError(e, module);
					}
				}

				if (lastDividendStored == null) {
					// first population for this stock

					for (String key : divMap.keySet()) {
						BigDecimal dividend = new BigDecimal(divMap.get(key));
						if (dividend.compareTo(BigDecimal.ZERO) != 0) {
							Map<String, Object> tmpResult = dispatcher.runSync("createBfinDividend", UtilMisc.<String, Object> toMap("userLogin", userLogin, "prodId", prodId,
									"dateLastCheckForPopulation", new Date(), "divFreqId", divFreqId, "amount", dividend, "date", sdf.parse(key)));
						}
					}

				} else {
					Date lastDividendStoredDate = (Date) lastDividendStored.get("date");
					for (String key : divMap.keySet()) {
						BigDecimal dividend = new BigDecimal(divMap.get(key));
						if (dividend.compareTo(BigDecimal.ZERO) != 0) {
							Date date = sdf.parse(key);
							Calendar cal1 = Calendar.getInstance();
							cal1.setTime(date);
							int month1 = cal1.get(Calendar.MONTH);
							int year1 = cal1.get(Calendar.YEAR);

							Calendar cal2 = Calendar.getInstance();
							cal2.setTime(lastDividendStoredDate);
							int month2 = cal2.get(Calendar.MONTH);
							int year2 = cal2.get(Calendar.YEAR);

							if (date.after(lastDividendStoredDate)) {
								if (!(year1 == year2 && month1 == month2)) {

									Map<String, Object> tmpResult = dispatcher.runSync("createBfinDividend", UtilMisc.<String, Object> toMap("userLogin", userLogin, "prodId", prodId,
											"dateLastCheckForPopulation", new Date(), "divFreqId", divFreqId, "amount", dividend, "date", sdf.parse(key)));
								}
							} else {
								dispatcher.runSync("updateBfinDividend",
										UtilMisc.<String, Object> toMap("divId", lastDividendStored.get("divId"), "dateLastCheckForPopulation", new Date(), "userLogin", userLogin));
								break;
							}
						}
					}

				}

				long stopTime = System.currentTimeMillis();
				long elapsedTime = stopTime - startTime;
				// To avoid transaction timeout and rollback
				if (elapsedTime > 100000) {
					Debug.logWarning("Exiting JOB time : " + elapsedTime, module);
					break;
				}
			}

		} catch (GenericEntityException e) {
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "RefRevenueZero", messageMap, locale);
			return ServiceUtil.returnError(errMsg);
		} catch (InterruptedException e) {
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "RefRevenueZero", messageMap, locale);
			return ServiceUtil.returnError(errMsg);
		} catch (Exception e) {
			long stopTime = System.currentTimeMillis();
			long elapsedTime = stopTime - startTime;
			Debug.logWarning("Exiting JOB time with exception: " + elapsedTime, module);
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "RefRevenueZero", messageMap, locale);
			return ServiceUtil.returnError(errMsg);
		}

		return result;
	}

	private static JSONObject sendGet(String symbol, String apikey) throws Exception {

		String url = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=" + symbol + "&apikey=" + apikey + "\"";

		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod("GET");

		// add request header
		con.setRequestProperty("User-Agent", USER_AGENT);

		// int responseCode = con.getResponseCode();
		// System.out.println("\nSending 'GET' request to URL : " + url);
		// System.out.println("Response Code : " + responseCode);

		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		JSONObject jsonObj = new JSONObject(response.toString());

		// print result
		// System.out.println(jsonObj.toString());
		// System.out.println("Symbol: " +
		// jsonObj.getJSONObject("Meta Data").get("2. Symbol"));
		return jsonObj;

	}

}

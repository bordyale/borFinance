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
import java.net.URLConnection;
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
import java.util.LinkedHashMap;
import java.util.stream.Collectors;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilDateTime;
import org.apache.ofbiz.base.util.UtilMisc;
import org.apache.ofbiz.base.util.UtilNumber;
import org.apache.ofbiz.base.util.UtilProperties;
import org.apache.ofbiz.base.util.UtilValidate;
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
import org.json.JSONArray;
import org.json.JSONException;

import java.util.Locale;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import java.security.cert.X509Certificate;

/**
 * Services for Agreement (Accounting)
 */

public class BorFinanceServices {

	public static final String module = BorFinanceServices.class.getName();

	public static final String resource = "BorFinanceUiLabels";
	public static final String emailTo = "alessio.bordignon@gmail.com";
	public static final String emailFrom = "alessio.bordignon@gmail.com";
	public static final String emailSbjct = module + " ";
	private static final String USER_AGENT = "Mozilla/5.0";

	private static final String[] apikey = { "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "IJMOD1FFWEBG5VWY", "TCWC4KTESJIY8UL5", "TCWC4KTESJIY8UL5",
			"TCWC4KTESJIY8UL5", "TCWC4KTESJIY8UL5", "TCWC4KTESJIY8UL5", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "WRFKAPP9TCNWQUKC", "NRXCKC71QSMJQZYA",
			"NRXCKC71QSMJQZYA", "NRXCKC71QSMJQZYA", "NRXCKC71QSMJQZYA", "NRXCKC71QSMJQZYA" };

	public static void sendBfinEmailVoid(LocalDispatcher dispatcher, GenericValue userLogin, Map<String, String> ctx) {

		String errMsg = null;

		Map<String, Object> sendMap = new HashMap<String, Object>();
		sendMap.put("userLogin", userLogin);
		sendMap.put("subject", emailSbjct + ctx.get("subject"));

		sendMap.put("sendFrom", emailFrom);

		sendMap.put("sendTo", emailTo);
		sendMap.put("body", ctx.get("body"));

		try {

			dispatcher.runSync("sendMail", sendMap);

		} catch (GenericServiceException e) {

			Debug.logError(e, errMsg, module);

		}
		return;

	}

	public static Map<String, Object> sendBfinEmail(DispatchContext ctx, Map<String, Object> context) {

		Debug.logWarning("Executing populDataYahooFin", module);

		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		LocalDispatcher dispatcher = ctx.getDispatcher();
		String errMsg = null;
		GenericValue userLogin = (GenericValue) context.get("userLogin");

		/*
		 * Map<String, Object> sendMap = new HashMap<String, Object>();
		 * sendMap.put("userLogin", userLogin); sendMap.put("subject", "test");
		 * 
		 * sendMap.put("sendFrom", "alessio.bordignon@gmail.com");
		 * 
		 * sendMap.put("sendTo", "alessio.bordignon@gmail.com");
		 * sendMap.put("body", "body Test");
		 * 
		 * try {
		 * 
		 * dispatcher.runSync("sendMail", sendMap);
		 * 
		 * } catch (GenericServiceException e) {
		 * 
		 * Debug.logError(e, errMsg, module); return
		 * ServiceUtil.returnError(errMsg); }
		 */
		sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "test email", "body", "prova body"));

		return result;
	}

	public static Map<String, Object> populDataYahooFin(DispatchContext ctx, Map<String, Object> context) {

		LocalDispatcher dispatcher = ctx.getDispatcher();

		Debug.logWarning("Executing populDataYahooFin", module);

		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");

		String errMsg = null;
		GenericValue userLogin = (GenericValue) context.get("userLogin");

		sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populDataYahooFin", "body", "populDataYahooFin exec"));

		long startTime = System.currentTimeMillis();
		try {
			List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("productType", EntityOperator.EQUALS, "STOCK"),
					EntityCondition.makeCondition("skipApi", EntityOperator.EQUALS, "EODH"));
			EntityCondition cond = EntityCondition.makeCondition(exprs, EntityOperator.AND);
			List<GenericValue> conditions = EntityQuery.use(delegator).from("BfinProduct").where(cond).orderBy("prodId ASC").queryList();

			SortedMap<String, Date> divMap = new TreeMap<String, Date>();
			for (GenericValue stock : conditions) {
				String symbol = (String) stock.get("prodSym");
				String prodId = (String) stock.get("prodId");
				String divFreqId = (String) stock.get("divFreqId");
				// String skipApi = (String) stock.get("skipApi");

				// Create a Map with symbol and last saved dividend.
				Calendar c = Calendar.getInstance();
				c.setTime(new Date());
				int backDayytocheck = -360;
				c.add(Calendar.DATE, backDayytocheck);
				GenericValue lastSavedDividend = EntityQuery.use(delegator).from("BfinDividend").where("prodId", prodId).cache().orderBy("date DESC").queryFirst();
				if (lastSavedDividend != null) {
					Date divDate = (Date) lastSavedDividend.get("dateLastCheckForPopulation");
					if (divDate == null) {
						divDate = c.getTime();
					}
					divMap.put(prodId, divDate);

				} else {
					divMap.put(prodId, c.getTime());
				}

			}
			// sort the map by value
			Map<String, Date> sortedDivMap = divMap.entrySet().stream().sorted(Map.Entry.comparingByValue())
					.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

			int i = 0;
			for (String prodId : sortedDivMap.keySet()) {

				GenericValue lastSavedDividend = EntityQuery.use(delegator).from("BfinDividend").where("prodId", prodId).cache().orderBy("date DESC").queryFirst();
				// String prodId = (String) lastSavedDividend.get("prodId");
				GenericValue product = EntityQuery.use(delegator).from("BfinProduct").where("prodId", prodId).cache().queryFirst();
				String symbol = (String) product.get("prodSym");
				String divFreqId = (String) product.get("divFreqId");

				// Debug.logWarning("POPULPRICE: " + key + " " + symbol + " " +
				// sortedPriceMap.get(key), module);

				String url = "https://rapidapi.p.rapidapi.com/stock/v2/get-summary?symbol=" + symbol;

				Map<String, String> headers = UtilMisc.toMap("x-rapidapi-host", "apidojo-yahoo-finance-v1.p.rapidapi.com", "x-rapidapi-key", "ed85e408ccmshd4093ee8f8f03a6p1b071bjsne338369de93a");
				Debug.logWarning("populDataYahooFin: " + symbol, module);
				String resp = sendGet(url, headers);
				if (resp == null) {
					Map<String, String> messageMap = UtilMisc.toMap("errMessage", "error jSON populDataYahooFin");
					errMsg = UtilProperties.getMessage(resource, "populDataYahooFin", messageMap, locale);
					sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populDataYahooFin", "body", "error jSON populDataYahooFin"));
					// return ServiceUtil.returnError(errMsg);
					break;
				}
				JSONObject respJson = new JSONObject(resp);

				JSONObject defaultKeyStatistics = respJson.getJSONObject("defaultKeyStatistics");

				BigDecimal lastDividendValue = new BigDecimal(String.valueOf(defaultKeyStatistics.getJSONObject("lastDividendValue").get("raw")));
				String lastDividendDate = defaultKeyStatistics.getJSONObject("lastDividendDate").getString("fmt");

				Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(lastDividendDate);

				Date lastSavedPDate = null;
				if (lastSavedDividend != null) {
					lastSavedPDate = (Date) lastSavedDividend.get("date");
				}

				if (lastSavedPDate == null || date1.compareTo(lastSavedPDate) > 0) {
					// System.out.println("Date 1 occurs after Date 2");
					try {
						if (lastDividendValue.compareTo(BigDecimal.ZERO) != 0) {
							Map<String, Object> tmpResult = dispatcher.runSync("createBfinDividend", UtilMisc.<String, Object> toMap("userLogin", userLogin, "prodId", prodId,
									"dateLastCheckForPopulation", new Date(), "divFreqId", divFreqId, "amount", lastDividendValue, "date", date1));
						}
					} catch (GenericServiceException e) {
						Debug.logError(e, module);
					}
				} else {
					dispatcher
							.runSync("updateBfinDividend", UtilMisc.<String, Object> toMap("divId", lastSavedDividend.get("divId"), "dateLastCheckForPopulation", new Date(), "userLogin", userLogin));
				}

				// API limit x day
				if (i >= 10) {
					break;
				}
				i++;
			}
		} catch (GenericEntityException e) {
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populDataYahooFin", "body", e.getMessage()));
			errMsg = UtilProperties.getMessage(resource, "RefRevenueZero", messageMap, locale);
			// return ServiceUtil.returnError(errMsg);
		} catch (Exception e) {
			long stopTime = System.currentTimeMillis();
			long elapsedTime = stopTime - startTime;
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populDataYahooFin", "body", e.getMessage()));
			Debug.logWarning("Exiting populPriceEODH JOB time with exception: " + elapsedTime, module);
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "populPrice", messageMap, locale);
			// return ServiceUtil.returnError(errMsg);
		}

		return result;
	}

	public static Map<String, Object> populPriceEODH(DispatchContext ctx, Map<String, Object> context) {

		Debug.logWarning("Executing populPriceEODH", module);

		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		LocalDispatcher dispatcher = ctx.getDispatcher();
		String errMsg = null;
		GenericValue userLogin = (GenericValue) context.get("userLogin");

		// If Sunday of Monday dont check previous day
		Calendar d = Calendar.getInstance();
		Date today = new Date();
		d.setTime(today);
		int dayOfWeek = d.get(Calendar.DAY_OF_WEEK);

		if (dayOfWeek == 1 || dayOfWeek == 2) {
			Debug.logWarning("ON DAY: " + new SimpleDateFormat("EE").format(today) + " DON'T EXECUTE populPriceEODH()", module);
			return result;
		}

		long startTime = System.currentTimeMillis();
		try {
			List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("productType", EntityOperator.EQUALS, "STOCK"),
					EntityCondition.makeCondition("skipApi", EntityOperator.EQUALS, "EODH"));
			EntityCondition cond = EntityCondition.makeCondition(exprs, EntityOperator.AND);
			List<GenericValue> conditions = EntityQuery.use(delegator).from("BfinProduct").where(cond).orderBy("prodId ASC").queryList();

			SortedMap<String, Date> priceMap = new TreeMap<String, Date>();
			for (GenericValue stock : conditions) {
				String symbol = (String) stock.get("prodSym");
				String prodId = (String) stock.get("prodId");
				String divFreqId = (String) stock.get("divFreqId");
				// String skipApi = (String) stock.get("skipApi");

				// Create a Map with symbol and last saved price.

				GenericValue lastSavedPrice = EntityQuery.use(delegator).from("BfinPrice").where("prodId", prodId).cache().orderBy("date DESC").queryFirst();
				if (lastSavedPrice != null) {
					Date priceDate = (Date) lastSavedPrice.get("date");
					priceMap.put(prodId, priceDate);

				} else {
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					int backDayytocheck = -180;
					c.add(Calendar.DATE, backDayytocheck);
					priceMap.put(prodId, c.getTime());
				}

			}
			// sort the map by value
			Map<String, Date> sortedPriceMap = priceMap.entrySet().stream().sorted(Map.Entry.comparingByValue())
					.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

			int i = 0;
			for (String key : sortedPriceMap.keySet()) {

				GenericValue product = EntityQuery.use(delegator).from("BfinProduct").where("prodId", key).cache().queryFirst();
				String symbol = (String) product.get("prodSym");

				// Debug.logWarning("POPULPRICE: " + key + " " + symbol + " " +
				// sortedPriceMap.get(key), module);

				Debug.logWarning("populPriceEODH: " + symbol, module);
				String url = "https://eodhistoricaldata.com/api/eod/" + symbol + "?order=d&api_token=5eaaa2678afb71.95618257&period=d&fmt=json";
				String resp = sendGet(url, null);
				if (resp == null) {
					Map<String, String> messageMap = UtilMisc.toMap("errMessage", "error jSON eodhistoricaldata");
					errMsg = UtilProperties.getMessage(resource, "eodhistoricaldata", messageMap, locale);
					sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populPriceEODH", "body", "error jSON eodhistoricaldata"));
					// return ServiceUtil.returnError(errMsg);
					break;
				}
				JSONArray arr = new JSONArray(resp);
				JSONObject lastDay = arr.getJSONObject(0);

				String date = (String) lastDay.get("date");
				BigDecimal lastClosePrice = new BigDecimal(String.valueOf(lastDay.get("close")));

				Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(date);
				Date lastSavedPDate = (Date) sortedPriceMap.get(key);
				if (date1.compareTo(lastSavedPDate) > 0) {
					System.out.println("Date 1 occurs after Date 2");
					try {
						Map<String, Object> tmpResult = dispatcher.runSync("createBfinPrice",
								UtilMisc.<String, Object> toMap("userLogin", userLogin, "date", date1, "price", lastClosePrice, "prodId", key));
					} catch (GenericServiceException e) {
						sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populPriceEODH", "body", e.getStackTrace()));
						Debug.logError(e, module);
					}
				}

				// API limit x day
				if (i >= 10) {
					break;
				}
				i++;
			}
		} catch (GenericEntityException e) {
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "populPriceEODH", messageMap, locale);
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populPriceEODH", "body", e.getMessage()));
			// return ServiceUtil.returnError(errMsg);
		} catch (Exception e) {
			long stopTime = System.currentTimeMillis();
			long elapsedTime = stopTime - startTime;
			Debug.logWarning("Exiting populPriceEODH JOB time with exception: " + elapsedTime, module);
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "populPriceEODH", messageMap, locale);
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populPriceEODH", "body", e.getMessage()));
			// return ServiceUtil.returnError(errMsg);
		}

		return result;
	}

	public static Map<String, Object> populateDividendTable(DispatchContext ctx, Map<String, Object> context) {

		Debug.logWarning("Executing populateDividendTable", module);
		// TO:DO remove locale set default
		Locale us = new Locale("en", "US", "USD");
		Locale.setDefault(us);
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

				if (skipApi != null && !"N".equals(skipApi)) {
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
					if (lastDividendStoredDateCheck != null && c.getTime().compareTo(lastDividendStoredDateCheck) < 0) {
						Debug.logWarning(symbol + " " + "LAST DIVIDEND ALREADY SAVED IN THE LAST " + backDayytocheck + " DAYS, SKiP API REQUEST", module);
						continue;
					}
				}
				i++;
				String url = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=" + symbol + "&apikey=" + apikey[5] + "\"";
				Debug.logWarning("populateDividendTable: " + symbol, module);
				String respStr = sendGet(url, null);
				// TODO: check if respStr == null;
				JSONObject resp = new JSONObject(respStr);
				JSONObject arr;
				try {
					arr = resp.getJSONObject("Monthly Adjusted Time Series");
				} catch (JSONException e) {
					Debug.logWarning(e, module);
					Debug.logError(symbol + " " + i + " " + resp.toString(), module);
					Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
					errMsg = UtilProperties.getMessage(resource, "JSONExpection", messageMap, locale);
					sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populateDividendTable", "body", e.getStackTrace()));
					// return ServiceUtil.returnError(errMsg);
					break;
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
			errMsg = UtilProperties.getMessage(resource, "populateDividendTable", messageMap, locale);
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populateDividendTable", "body", e.getMessage()));
			// return ServiceUtil.returnError(errMsg);
		} catch (InterruptedException e) {
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "populateDividendTable", messageMap, locale);
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populateDividendTable", "body", e.getMessage()));
			// return ServiceUtil.returnError(errMsg);
		} catch (Exception e) {
			long stopTime = System.currentTimeMillis();
			long elapsedTime = stopTime - startTime;
			Debug.logWarning("Exiting JOB time with exception: " + elapsedTime, module);
			Debug.logWarning(e, module);
			Map<String, String> messageMap = UtilMisc.toMap("errMessage", e.getMessage());
			errMsg = UtilProperties.getMessage(resource, "populateDividendTable", messageMap, locale);
			sendBfinEmailVoid(dispatcher, userLogin, UtilMisc.<String, String> toMap("subject", "populateDividendTable", "body", e.getMessage()));
			// return ServiceUtil.returnError(errMsg);
		}

		return result;
	}

	private static String sendGet(String url, Map<String, String> headers) throws Exception {

		// Create a trust manager that does not validate certificate chains
		TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
			public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				return null;
			}

			public void checkClientTrusted(X509Certificate[] certs, String authType) {
			}

			public void checkServerTrusted(X509Certificate[] certs, String authType) {
			}
		} };

		// Install the all-trusting trust manager
		SSLContext sc = SSLContext.getInstance("SSL");
		sc.init(null, trustAllCerts, new java.security.SecureRandom());
		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

		// Create all-trusting host name verifier
		HostnameVerifier allHostsValid = new HostnameVerifier() {
			public boolean verify(String hostname, SSLSession session) {
				return true;
			}
		};

		// Install the all-trusting host verifier
		HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		if (headers != null) {
			for (String key : headers.keySet()) {
				con.setRequestProperty(key, headers.get(key));

			}
		}
		// URLConnection con = obj.openConnection();

		int code = con.getResponseCode();
		if (code != 200) {
			return null;
		}

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
		// JSONObject jsonObj = new JSONObject(response.toString());
		return response.toString();

		// print result
		// System.out.println(jsonObj.toString());
		// System.out.println("Symbol: " +
		// jsonObj.getJSONObject("Meta Data").get("2. Symbol"));
		// return jsonObj;

	}

}

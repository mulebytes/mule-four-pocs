%dw 2.0
import modules::commonFunctions as commonFun
fun printLog(logMessage,payload,vars,app,flow,attributes)={
	appName: app.name,
	environment: commonFun::getEnv(),
	flowName: vars.flowName default flow.name,
	transactionId: vars.correlationId,
	requestTimeStamp: vars.requestTimeStamp,
	logMessage: logMessage,
	requestDetails:{
		protocol: attributes.scheme,
		method: attributes.method,
		requestUri: attributes.requestUri
	},
	headers: attributes.headers,
	queryParams: attributes.queryParams,
	(currentPayload: commonFun::printPayload(payload)) if(commonFun::getLogDebugEnabled() or ((vars.localLogDebugEnabled default false) == true) or ((vars.headerLogDebugEnabled default false) == true))
}

fun printErrorLog(logMessage,payload,vars,app,flow,error,attributes)={
	appName: app.name,
	environment: commonFun::getEnv(),
	flowName: vars.flowName default flow.name,
	transactionId: vars.correlationId,
	requestTimeStamp: vars.requestTimeStamp,
	logMessage: logMessage,
	requestDetails:{
		protocol: attributes.scheme,
		method: attributes.method,
		requestUri: attributes.requestUri
	},
	headers: attributes.headers,
	queryParams: attributes.queryParams,	
	(failingComponent: error.failingComponent) if(error !=null),
	(errorType: [error.errorType.namespace default "APP",error.errorType.identifier default "ERROR"] joinBy ":")  if(error !=null),
	(errorDescription: error.description default "Error Occurred" replace "\"" with "") if(error !=null),	
	(currentPayload: commonFun::printPayload(payload)) if(commonFun::getLogDebugEnabled() or ((vars.localLogDebugEnabled default false) == true) or ((vars.headerLogDebugEnabled default false) == true))
}
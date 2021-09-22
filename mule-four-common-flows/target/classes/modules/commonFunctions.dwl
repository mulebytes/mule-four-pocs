%dw 2.0
import dw::Core
fun getRequestTimeStamp(vars)=(
	vars.requestTimeStamp default (now() as String {format: "yyyy-MM-dd'T'HH_mm_ss.SSS"})
)

fun getEnv()=(
	Mule::p('env')
)

fun getLogDebugEnabled()=(
	(Mule::p('logDebugEnabled') default false) as Boolean 
)

fun printPayload(payload)=(
	if ( payload != null and (isEmpty(payload)) != true ) 
		if(payload.^mimeType == "application/json")
			payload
		else
			write(payload, "$(payload.^mimeType)") 	
	else null
)

fun stringContainsInArray(inputString,inputArray)=(
	(inputArray map ((currentItem, index) -> if(currentItem is String) (upper(inputString) contains upper(currentItem)) else false)) contains true
)
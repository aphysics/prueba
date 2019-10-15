xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="ar.com.cablevision.ProductManagement.GetEquipmentConsumption";
(:: import schema at "../Specification/Expose/XSD/VAC_GetEquipmentConsumption.xsd" ::)

declare variable $data as element() external;

declare function local:returnDateTime($pYear as xs:string, $pMonth as xs:string, $pDay as xs:string, $pHour as xs:string, $pMinute as xs:string, $pSecond as xs:string)		   
        as xs:dateTime 
  { 
        (: Se obtienen los valores para año, mes y dia :)
        let $year := $pYear,
                $month := if(string-length($pMonth) = 1) then concat('0', $pMonth) else $pMonth,
                $day := if(string-length($pDay) = 1) then concat('0', $pDay) else $pDay,         
                $date := fn:concat($year, '-', $month, '-', $day),
                $hour := if(string-length($pHour) = 1) then concat('0', $pHour) else $pHour,
                $minute := if(string-length($pMinute) = 1) then concat('0', $pMinute) else $pMinute,
                $second := if(string-length($pSecond) = 1) then concat('0', $pSecond) else $pSecond,
                $time := fn:concat($hour, ':', $minute, ':', $second, '-03:00'),
                $dateTime := concat(xs:date($date), 'T', xs:time($time))                                                                           
        return   
           xs:dateTime($dateTime)

}; 


declare function local:func($data as element() ) as element() (:: schema-element(ns1:GetEquipmentConsumptionResponse) ::) {
 let $datosEquipo:= fn-bea:inlinedXML($data/return/respuestasSolicitudes/respuestasAcciones/valorRetorno/text()) return
    <ns1:GetEquipmentConsumptionResponse>
    {
            for $message in $datosEquipo/message
            return
                    <ns1:message>{ data($message) }</ns1:message>
    }				
    {
            for $requestedSubscriberId in $datosEquipo/requestedSubscriberId
            return
                    <ns1:requestedSubscriberId>{ data($requestedSubscriberId) }</ns1:requestedSubscriberId>
    }            
    {
            for $com.cablevision.callis.DynamicSessions in $datosEquipo/dynamicSessions/com.cablevision.callis.DynamicSession
            return
                    <ns1:dynamicSessions>
                            (: La fecha de activacion puede venir en distintos formatos :)
                            <ns1:activateDate>
                            { if (substring(data($com.cablevision.callis.DynamicSessions/activateDate),10,1)='T') then (data($com.cablevision.callis.DynamicSessions/activateDate))
                            else if  (string-length(data($com.cablevision.callis.DynamicSessions/activateDate)) = 10) then (concat(data($com.cablevision.callis.DynamicSessions/activateDate),'T00:00:00')) 
                            else (concat(substring(data($com.cablevision.callis.DynamicSessions/activateDate),1,10),'T',substring(data($com.cablevision.callis.DynamicSessions/activateDate),12,8)) )
                            }
                            </ns1:activateDate> 
                            <ns1:dynamicServiceId>{ data($com.cablevision.callis.DynamicSessions/dynamicServiceId) }</ns1:dynamicServiceId>
                            <ns1:dynamicServiceName>{ data($com.cablevision.callis.DynamicSessions/dynamicServiceName) }</ns1:dynamicServiceName> 
                            <ns1:bothStreamVolumePercentValue>{ data($com.cablevision.callis.DynamicSessions/bothStreamVolumePercentValue) }</ns1:bothStreamVolumePercentValue>
                            <ns1:bothStreamVolumeRemainingValue>{ data($com.cablevision.callis.DynamicSessions/bothStreamVolumeRemainingValue) }</ns1:bothStreamVolumeRemainingValue>
                            <ns1:bothStreamVolumeTrafficCounter>{ data($com.cablevision.callis.DynamicSessions/bothStreamVolumeTrafficCounter) }</ns1:bothStreamVolumeTrafficCounter>
                            <ns1:bothStreamVolumeUserLimit>{ data($com.cablevision.callis.DynamicSessions/bothStreamVolumeUserLimit) }</ns1:bothStreamVolumeUserLimit>
                            <ns1:countingTimeType>{ data($com.cablevision.callis.DynamicSessions/countingTimeType) }</ns1:countingTimeType>
                            <ns1:downStreamVolumePercentValue>{ data($com.cablevision.callis.DynamicSessions/downStreamVolumePercentValue) }</ns1:downStreamVolumePercentValue>
                            <ns1:downStreamVolumeRemainingValue>{ data($com.cablevision.callis.DynamicSessions/downStreamVolumeRemainingValue) }</ns1:downStreamVolumeRemainingValue>
                            <ns1:downStreamVolumeTrafficCounter>{ data($com.cablevision.callis.DynamicSessions/downStreamVolumeTrafficCounter) }</ns1:downStreamVolumeTrafficCounter>
                            <ns1:downStreamVolumeUserLimit>{ data($com.cablevision.callis.DynamicSessions/downStreamVolumeVolumeUserLimit) }</ns1:downStreamVolumeUserLimit>
                            <ns1:timePercentValue>{ data($com.cablevision.callis.DynamicSessions/timePercentValue) }</ns1:timePercentValue>
                            <ns1:timeRemainingValue>{ data($com.cablevision.callis.DynamicSessions/timeRemainingValue) }</ns1:timeRemainingValue>
                            <ns1:timeTrafficCounter>{ data($com.cablevision.callis.DynamicSessions/timeTrafficCounter) }</ns1:timeTrafficCounter>
                            <ns1:timeUserLimit>{ data($com.cablevision.callis.DynamicSessions/timeUserLimit) }</ns1:timeUserLimit>
                            <ns1:upStreamVolumePercentValue>{ data($com.cablevision.callis.DynamicSessions/upStreamVolumePercentValue) }</ns1:upStreamVolumePercentValue>
                            <ns1:upStreamVolumeRemainingValue>{ data($com.cablevision.callis.DynamicSessions/upStreamVolumeRemainingValue) }</ns1:upStreamVolumeRemainingValue>
                            <ns1:upStreamVolumeTrafficCounter>{ data($com.cablevision.callis.DynamicSessions/upStreamVolumeTrafficCounter) }</ns1:upStreamVolumeTrafficCounter>
                            <ns1:sessionId>{ data($com.cablevision.callis.DynamicSessions/sessionId) }</ns1:sessionId>
                            <ns1:state>{ data($com.cablevision.callis.DynamicSessions/state) }</ns1:state>
                    </ns1:dynamicSessions>
    }
    </ns1:GetEquipmentConsumptionResponse>
};

local:func($data)

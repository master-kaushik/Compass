require "import"
import "android.hardware.*"
import "android.widget.*"
FormFitFunctionAndInterface = float[16]
mAttitude = float[3]
mCompass = ""
mGeomagnetic = float[3]
mGravity = float[3]
mInR = float[16]
mOrientation = float[3]
mOutR = float[16]
layout={
TextView, id="mt",gravity="center",TextSize="50",layout_height="match_parent",layout_width="match_parent"
}
this.setTitle("COMPASS")
this.setContentView(loadlayout(layout))
mSensorManager = this.getSystemService(this.SENSOR_SERVICE)
listener=SensorEventListener{
onSensorChanged=function(sensorEvent)
type = sensorEvent.sensor.getType()
if type == 1 then
mGravity = sensorEvent.values
elseif type == 2 then
mGeomagnetic = sensorEvent.values
elseif type == 3 then
mOrientation = sensorEvent.values
end
sensorEvent = mGravity
if sensorEvent then
fArr = mGeomagnetic
if fArr and mOrientation then
SensorManager.getRotationMatrix(mInR,FormFitFunctionAndInterface,sensorEvent,fArr)
SensorManager.remapCoordinateSystem(mInR,1,2,mOutR)
SensorManager.getOrientation(mOutR,mAttitude)
sensorEvent = math.deg(mAttitude[0])
mCompass = nil
d = sensorEvent
if 22.5 <= d and d < 67.5 then
mCompass = "NORTH EAST"
elseif 67.5 <= d and d < 112.5 then
mCompass = "EAST"
elseif 112.5 <= d and d < 157.5 then
mCompass = "SOUTH EAST"
elseif 157.5 <= d or d < -157.5 then
mCompass = "SOUTH"
elseif d >= -157.5 and d < -112.5 then
mCompass = "SOUTH WEST"
elseif d >= -112.5 and d < -67.5 then
mCompass = "WEST"
elseif d >= -67.5 and d < -22.5 then
mCompass = "NORTH WEST"
else
mCompass = "NORTH"
end
mt.text=mCompass
if not service.isSpeaking() then
service.speak(mCompass)
end
end
end
end}
function onCreate()
mSensorManager.registerListener(listener,mSensorManager.getDefaultSensor(1),2)
mSensorManager.registerListener(listener,mSensorManager.getDefaultSensor(2),2)
mSensorManager.registerListener(listener,mSensorManager.getDefaultSensor(3),2)
end
function onDestroy()
mSensorManager.unregisterListener(listener)
end

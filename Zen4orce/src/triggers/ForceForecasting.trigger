trigger ForceForecasting on User (before insert,before update) {
for(User u:Trigger.new){
u.ForecastEnabled = true;
}
}
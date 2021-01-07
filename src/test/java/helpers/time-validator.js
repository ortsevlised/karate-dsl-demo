function fn(s) {
    var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
    var sdf = new SimpleDateFormat("dd/mm/yyyy");
    try {
        sdf.parse(s).time;
        return true;
    } catch(e) {
        karate.log('*** invalid date string:', s);
        return false;
    }
}
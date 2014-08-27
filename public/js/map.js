var map;
var marker;
var latID;
var longID;
function initialize() {
  var myLatlng;
//http://localhost:9000/API/v1/MapDetails?Account_id=1
  var mapOptions = {
        zoom: 6,
        //the level of zoom when it loads, the lower the number the more zoomed out you are
        center: new google.maps.LatLng(53.422628, -7.756348),
        //set the center at the start
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        panControl: false,
        zoomControl: true,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        overviewMapControl: true
        //these are all the controls, I wanted basic layout so turned most off
    };

  myLatlng = new google.maps.LatLng(53.422628,-7.756348);
      var mapOptions = {
        zoom: 6 ,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
  map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	if(latID != '' && longID != '')
	{
		marker = new google.maps.Marker({
		    position: myLatlng,
		    map: map,
		    animation: google.maps.Animation.DROP
		});
	}
  map.setCenter(location);

  var styles = [
	  {
	    "featureType": "landscape",
	    "stylers": [
	      { "color": "#049cde" }
	    ]
	  },{
	    "featureType": "road.highway",
	    "stylers": [
	      { "hue": "#0099ff" }
	    ]
	  },{
	    "featureType": "water",
	    "stylers": [
	      { "hue": "#00ff4d" },
	      { "color": "#040404" }
	    ]
	  },{
	    "featureType": "road.arterial",
	    "stylers": [
	      { "hue": "#00fff7" }
	    ]
	  }
	];
	//add the styles
	map.setOptions({styles: styles});
}

function loadScript() {
    latID = 53.189651
    longID = -6.350074
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyAFaMgyNCb_5sdcjmh5AbhG2B-eaCjsN5Y&sensor=true&callback=initialize";
    //key in this is my API key, get another one because I have loads of things linked to it and a limit that if it 
    //goes over I have to pay money, use it for testing if you like but change before production
    document.body.appendChild(script);
  }

 // window.onload = loadScript;
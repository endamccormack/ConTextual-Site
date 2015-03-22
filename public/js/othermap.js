
var map;
var theLats;
var theLongs;
var dataType;

var theJson;
var markers = new Array(); 
var imgStr;
var infowindow;

google.load("maps", "3");
google.setOnLoadCallback(initialize);

function initialize() {

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

	testJson();
    
    theLats = new Array();
	theLongs = new Array();
	//just 2 arrays with latatudes and longatudes for places
	
	var theImgs=new Array("redpin32.png", "orangepin32.png", "greenpin32.png" );
	//just 3 different custom images these are just place holders do not use, they look rotten!

	//make 3 markers with the positions and images set in the arrays
	

	
	//get the map
  	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);  	

	//changing the colors and looks of the map, fairly self explanator
	var styles = [
	  {
	    "featureType": "landscape",
	    "stylers": [
	      { "color": "#ff9900" }
	    ]
	  },{
	    "featureType": "road.highway",
	    "stylers": [
	      { "hue": "#fff" }
	    ]
	  },{
	    "featureType": "water",
	    "stylers": [
	      { "hue": "#323232" },
	      { "color": "#323232" }
	    ]
	  },{
	    "featureType": "road.arterial",
	    "stylers": [
	      { "hue": "#fff" }
	    ]
	  }
	];

	var contentString = "Hi";

	infowindow = new google.maps.InfoWindow({
	  content: contentString
	});
	//add the styles
	map.setOptions({styles: styles});

	doMarkers();

	//add the event listeners to the DOM
	google.maps.event.addDomListener(window, 'load', initialize);
}


	//function for what to do when it loads
	// function loadScript() {
	// 	// var script = document.createElement("script");
	// 	// script.type = "text/javascript";
	// 	// script.src = "";
	// 	// //key in this is my API key, get another one because I have loads of things linked to it and a limit that if it 
	// 	// //goes over I have to pay money, use it for testing if you like but change before production
	// 	// document.body.appendChild(script);
	// }

	// //when the page loads fire the loadScript
	// window.onload = loadScript;

	function doStuff()
	{
	  $('#map').animate({
	    height: '400px',
	    width: '400px'
	  },200, function(){
	  	//vip, this is extremely important and took a while to find out, this reinitializes the map when resized
  		google.maps.event.trigger(map, 'resize');
	  });
	  
	}

	function doMarkers()
	{
		clearMarkerListeners();
		markers = new Array();
		
		for(var i = 0; i < theJson.length; i++)
		{
			//alert(theJson[i].Title)
			 imgStr = "/img/orange.png";
			 markers[i] = new google.maps.Marker({
				Title: theJson[i].Title,
				Description: theJson[i].Description,
				position: new google.maps.LatLng(theJson[i].Lat,theJson[i].Long),//the position of where it is on map
				animation: google.maps.Animation.DROP,//just threw in a drop animation because it looks cool
				icon: new google.maps.MarkerImage( 
					imgStr,//the image url string
					null, /* size is determined at runtime */
					null, /* origin is 0,0 */
					null, /* anchor is bottom center of the scaled image */
					new google.maps.Size(32, 32)//resolution of the image
			   )
			});
		}

		//add the markers to the map
	  	for(var i = 0; i < markers.length; i++)
			{
				markers[i].setMap(map);
			google.maps.event.addListener(markers[i], 'click', function() {
				var sRes; // search result

				infowindow.content = "<bold>" + this.title + "</bold><br/><bold> Description:</bold> " + this.Description;
				infowindow.open(map,this);
				// map.setZoom(16);
				// map.setCenter(this.getPosition());
				});
		}

	}

	function clearMarkerListeners()
	{				
		if (markers.length > 0)
			{
				for(var i = 0; i < markers.length; i++)
  				{
					google.maps.event.clearListeners(markers[i], 'click');
					markers[i].setMap(null);
				}
			}
	}

	function testJson(){
		//XMLHttpRequest cannot load http://localhost:9000/API/v1/MapDetails?Account_id=1. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:3000' is therefore not allowed access. 
		var jstr = '[{"id":1,"Title":"Dublin","Description":"Sales improve +5% in the last week","Lat":"53.347754","Long":" -6.250511","Account_id":1,"Campaign_id":4},{"id":2,"Title":"Cork","Description":"Sales improve +5% in the last week","Lat":"51.903663","Long":"-8.392923","Account_id":1,"Campaign_id":4},{"id":3,"Title":"Limerick","Description":"Sales improve +5% in the last week","Lat":"52.666717","Long":"-8.631513","Account_id":1,"Campaign_id":4},{"id":4,"Title":"Galway","Description":"Sales improve +5% in the last week","Lat":"53.285655","Long":"-9.015520","Account_id":1,"Campaign_id":4},{"id":5,"Title":"Sligo","Description":"Sales improve +5% in the last week","Lat":"54.270193","Long":"-8.470477","Account_id":1,"Campaign_id":4}]'

		theJson = JSON.parse(jstr);
	}
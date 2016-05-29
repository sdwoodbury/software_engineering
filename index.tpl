<!--index.tpl-->
<!--provides the front end for Klystron-911 -->
<!DOCTYPE html > 
<html>
  <head>
    <meta charset="utf-8">
	<meta http-equiv="Cache-control" content="no-cache">
	<meta http-equiv="Expires" content="-1">
    <title>Klystron 911</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <style>
	.dropdown-menu li{
   		font-size:10px
	}
        #draggable { width: 160px; height: 150px; padding: 0.5em; position: relative; top: 155px; left: 10px; }
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }

/* the loading overlay GIF when waiting for a query to return */
      .modalLoad {
    display:    none;
    position:   fixed;
    z-index:    200;
    top:        0;
    left:       0;
    height:     100%;
    width:      100%;
    background: rgba( 255, 255, 255, .8 )
                url('http://sampsonresume.com/labs/pIkfp.gif')
                50% 50%
                no-repeat;
        }

        /* When the body has the loading class, we turn
        the scrollbar off with overflow:hidden */
        body.loading {
                overflow: hidden;
        }

        /* Anytime the body has the loading class, our
        modalLoad element will be visible */
        body.loading .modalLoad {
                display: block;
        }
    </style>

	<script>
	//initialize data resource
	var data;
        var ajaxInProgress = false;
	var customQueryNumber = 1;
	</script>


	<link rel="stylesheet" href="css/iThing.css" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="css/lists.css">
	<script src='lib/bootstrap.js'></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.1.2/markerclustererplus/src/markerclusterer.js"></script>
	<script src='lib/tablesorter.js'></script>
	<script src='lib/bootbox.js'></script>
	<script src="http://code.highcharts.com/stock/highstock.js"></script>
	<script src="http://code.highcharts.com/stock/modules/exporting.js"></script>

	<script>
	function setCookie(val){
		document.cookie="view=".concat(val, ";");
	}
        function toTitleCase(str)
        {
		if(!str) { return "<empty>"; }
                return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
        }
	</script>


	<script>
		//show views on respective menu button clicks
		$(document).ready(function(){

		$.getScript( "https://maps.googleapis.com/maps/api/js?key=AIzaSyAaJWXKpqTCLv-ZYpbplX_fmOXm3Jgmonc&signed_in=true&libraries=visualization&callback=initMap", function() {
  		console.log( "Maps Api Load was performed." );
		});
        $("#myTable").DataTable();
    		$("#Map").click(function(){
        		$("#map").show();
                                $("#floating-panel").show();
				$("#chart").hide();
				$("#table").hide();

				setCookie("map");
				renderMap();
				//initMap();
    		});
    		$("#Chart").click(function(){
        		$("#map").hide();
                                $("#floating-panel").hide();
				$("#table").hide();
				$("#chart").show();
                                $("#draggable").hide();
				setCookie("chart");
    		});
			$("#Table").click(function(){
        		$("#map").hide();
                                $("#floating-panel").hide();
				$("#chart").hide();
				$("#table").show();
                                $("#draggable").hide();
				setCookie("table");
		                drawCrimeType();

    		});

// checkboxes automatically submit a query

// crime types
$("#crime_all").click(function(){$("#crimeFilters").submit();});
$("#agg._assault").click(function(){$("#crimeFilters").submit();});
$("#arson").click(function(){$("#crimeFilters").submit();});
$("#assault_by_threat").click(function(){$("#crimeFilters").submit();});
$("#auto_theft").click(function(){$("#crimeFilters").submit();});
$("#burglary").click(function(){$("#crimeFilters").submit();});
$("#common_assault").click(function(){$("#crimeFilters").submit();});
$("#homicide").click(function(){$("#crimeFilters").submit();});
$("#larceny").click(function(){$("#crimeFilters").submit();});
$("#larceny_from_auto").click(function(){$("#crimeFilters").submit();});
$("#rape").click(function(){$("#crimeFilters").submit();});
$("#robbery_-_carjacking").click(function(){$("#crimeFilters").submit();});
$("#robbery_-_commercial").click(function(){$("#crimeFilters").submit();});
$("#robbery_-_residence").click(function(){$("#crimeFilters").submit();});
$("#robbery_-_street").click(function(){$("#crimeFilters").submit();});
$("#shooting").click(function(){$("#crimeFilters").submit();});

// neighborhoods
			$("#neighborhood_all").click(function(){$("#crimeFilters").submit();});
			$("#neighborhood_none").click(function(){$("#crimeFilters").submit();});
$("#abell").click(function(){$("#crimeFilters").submit();});
$("#allendale").click(function(){$("#crimeFilters").submit();});
$("#arcadia").click(function(){$("#crimeFilters").submit();});
$("#arlington").click(function(){$("#crimeFilters").submit();});
$("#armistead_gardens").click(function(){$("#crimeFilters").submit();});
$("#ashburton").click(function(){$("#crimeFilters").submit();});
$("#baltimore_highlands").click(function(){$("#crimeFilters").submit();});
$("#barclay").click(function(){$("#crimeFilters").submit();});
$("#barre_circle").click(function(){$("#crimeFilters").submit();});
$("#bayview").click(function(){$("#crimeFilters").submit();});
$("#beechfield").click(function(){$("#crimeFilters").submit();});
$("#belair-edison").click(function(){$("#crimeFilters").submit();});

$("#belair-parkside").click(function(){$("#crimeFilters").submit();});
$("#bellona-gittings").click(function(){$("#crimeFilters").submit();});
$("#belvedere").click(function(){$("#crimeFilters").submit();});
$("#berea").click(function(){$("#crimeFilters").submit();});
$("#better_waverly").click(function(){$("#crimeFilters").submit();});
$("#beverly_hills").click(function(){$("#crimeFilters").submit();});
$("#biddle_street").click(function(){$("#crimeFilters").submit();});
$("#blythewood").click(function(){$("#crimeFilters").submit();});
$("#bolton_hill").click(function(){$("#crimeFilters").submit();});
$("#boyd-booth").click(function(){$("#crimeFilters").submit();});
$("#brewers_hill").click(function(){$("#crimeFilters").submit();});
$("#bridgeviewgreenlawn").click(function(){$("#crimeFilters").submit();});
$("#broadway_east").click(function(){$("#crimeFilters").submit();});
$("#broening_manor").click(function(){$("#crimeFilters").submit();});
$("#brooklyn").click(function(){$("#crimeFilters").submit();});
$("#burleith-leighton").click(function(){$("#crimeFilters").submit();});
$("#butchers_hill").click(function(){$("#crimeFilters").submit();});
$("#care").click(function(){$("#crimeFilters").submit();});
$("#callaway-garrison").click(function(){$("#crimeFilters").submit();});

$("#cameron_village").click(function(){$("#crimeFilters").submit();});
$("#canton").click(function(){$("#crimeFilters").submit();});
$("#canton_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#carroll_-_camden_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#carroll_park").click(function(){$("#crimeFilters").submit();});
$("#carroll-south_hilton").click(function(){$("#crimeFilters").submit();});
$("#carrollton_ridge").click(function(){$("#crimeFilters").submit();});
$("#cedarcroft").click(function(){$("#crimeFilters").submit();});
$("#cedmont").click(function(){$("#crimeFilters").submit();});
$("#cedonia").click(function(){$("#crimeFilters").submit();});
$("#central_forest_park").click(function(){$("#crimeFilters").submit();});
$("#central_park_heights").click(function(){$("#crimeFilters").submit();});
$("#charles_north").click(function(){$("#crimeFilters").submit();});
$("#charles_village").click(function(){$("#crimeFilters").submit();});
$("#cherry_hill").click(function(){$("#crimeFilters").submit();});
$("#cheswolde").click(function(){$("#crimeFilters").submit();});
$("#chinquapin_park").click(function(){$("#crimeFilters").submit();});
$("#clifton_park").click(function(){$("#crimeFilters").submit();});
$("#coldspring").click(function(){$("#crimeFilters").submit();});
$("#coldstream_homestead_montebello").click(function(){$("#crimeFilters").submit();});
$("#concerned_citizens_of_forest_park").click(function(){$("#crimeFilters").submit();});
$("#coppin_heightsash-co-east").click(function(){$("#crimeFilters").submit();});
$("#cross_country").click(function(){$("#crimeFilters").submit();});
$("#cross_keys").click(function(){$("#crimeFilters").submit();});
$("#curtis_bay").click(function(){$("#crimeFilters").submit();});
$("#curtis_bay_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#cylburn").click(function(){$("#crimeFilters").submit();});
$("#darley_park").click(function(){$("#crimeFilters").submit();});
$("#dickeyville").click(function(){$("#crimeFilters").submit();});
$("#dolfield").click(function(){$("#crimeFilters").submit();});
$("#dorchester").click(function(){$("#crimeFilters").submit();});
$("#downtown").click(function(){$("#crimeFilters").submit();});
$("#downtown_west").click(function(){$("#crimeFilters").submit();});
$("#druid_heights").click(function(){$("#crimeFilters").submit();});
$("#druid_hill_park").click(function(){$("#crimeFilters").submit();});
$("#dunbar-broadway").click(function(){$("#crimeFilters").submit();});
$("#dundalk_marine_terminal").click(function(){$("#crimeFilters").submit();});
$("#east_arlington").click(function(){$("#crimeFilters").submit();});
$("#east_baltimore_midway").click(function(){$("#crimeFilters").submit();});
$("#easterwood").click(function(){$("#crimeFilters").submit();});
$("#eastwood").click(function(){$("#crimeFilters").submit();});
$("#edgewood").click(function(){$("#crimeFilters").submit();});
$("#edmondson_village").click(function(){$("#crimeFilters").submit();});
$("#ednor_gardens-lakeside").click(function(){$("#crimeFilters").submit();});
$("#ellwood_parkmonument").click(function(){$("#crimeFilters").submit();});
$("#evergreen").click(function(){$("#crimeFilters").submit();});
$("#evergreen_lawn").click(function(){$("#crimeFilters").submit();});
$("#evesham_park").click(function(){$("#crimeFilters").submit();});
$("#fairfield_area").click(function(){$("#crimeFilters").submit();});
$("#fairmont").click(function(){$("#crimeFilters").submit();});
$("#fallstaff").click(function(){$("#crimeFilters").submit();});
$("#federal_hill").click(function(){$("#crimeFilters").submit();});
$("#fells_point").click(function(){$("#crimeFilters").submit();});
$("#forest_park").click(function(){$("#crimeFilters").submit();});
$("#forest_park_golf_course").click(function(){$("#crimeFilters").submit();});
$("#four_by_four").click(function(){$("#crimeFilters").submit();});
$("#frankford").click(function(){$("#crimeFilters").submit();});
$("#franklin_square").click(function(){$("#crimeFilters").submit();});
$("#franklintown").click(function(){$("#crimeFilters").submit();});
$("#franklintown_road").click(function(){$("#crimeFilters").submit();});
$("#garwyn_oaks").click(function(){$("#crimeFilters").submit();});
$("#gay_street").click(function(){$("#crimeFilters").submit();});
$("#glen").click(function(){$("#crimeFilters").submit();});
$("#glen_oaks").click(function(){$("#crimeFilters").submit();});
$("#glenham-belhar").click(function(){$("#crimeFilters").submit();});
$("#graceland_park").click(function(){$("#crimeFilters").submit();});
$("#greektown").click(function(){$("#crimeFilters").submit();});
$("#greenmount_cemetery").click(function(){$("#crimeFilters").submit();});
$("#greenmount_west").click(function(){$("#crimeFilters").submit();});
$("#greenspring").click(function(){$("#crimeFilters").submit();});
$("#grove_park").click(function(){$("#crimeFilters").submit();});
$("#guilford").click(function(){$("#crimeFilters").submit();});
$("#gwynns_falls").click(function(){$("#crimeFilters").submit();});
$("#gwynns_fallsleakin_park").click(function(){$("#crimeFilters").submit();});
$("#hamilton_hills").click(function(){$("#crimeFilters").submit();});
$("#hampden").click(function(){$("#crimeFilters").submit();});
$("#hanlon-longwood").click(function(){$("#crimeFilters").submit();});
$("#harlem_park").click(function(){$("#crimeFilters").submit();});
$("#harwood").click(function(){$("#crimeFilters").submit();});
$("#hawkins_point").click(function(){$("#crimeFilters").submit();});
$("#heritage_crossing").click(function(){$("#crimeFilters").submit();});
$("#herring_run_park").click(function(){$("#crimeFilters").submit();});
$("#highlandtown").click(function(){$("#crimeFilters").submit();});
$("#hillen").click(function(){$("#crimeFilters").submit();});
$("#hoes_heights").click(function(){$("#crimeFilters").submit();});
$("#holabird_industrial_park").click(function(){$("#crimeFilters").submit();});
$("#hollins_market").click(function(){$("#crimeFilters").submit();});
$("#homeland").click(function(){$("#crimeFilters").submit();});
$("#hopkins_bayview").click(function(){$("#crimeFilters").submit();});
$("#howard_park").click(function(){$("#crimeFilters").submit();});
$("#hunting_ridge").click(function(){$("#crimeFilters").submit();});
$("#idlewood").click(function(){$("#crimeFilters").submit();});
$("#inner_harbor").click(function(){$("#crimeFilters").submit();});
$("#irvington").click(function(){$("#crimeFilters").submit();});
$("#johns_hopkins_homewood").click(function(){$("#crimeFilters").submit();});
$("#johnston_square").click(function(){$("#crimeFilters").submit();});
$("#jones_falls_area").click(function(){$("#crimeFilters").submit();});
$("#jonestown").click(function(){$("#crimeFilters").submit();});
$("#kenilworth_park").click(function(){$("#crimeFilters").submit();});
$("#kernewood").click(function(){$("#crimeFilters").submit();});
$("#keswick").click(function(){$("#crimeFilters").submit();});
$("#kresson").click(function(){$("#crimeFilters").submit();});
$("#lake_evesham").click(function(){$("#crimeFilters").submit();});
$("#lake_walker").click(function(){$("#crimeFilters").submit();});
$("#lakeland").click(function(){$("#crimeFilters").submit();});
$("#langston_hughes").click(function(){$("#crimeFilters").submit();});
$("#lauraville").click(function(){$("#crimeFilters").submit();});
$("#levindale").click(function(){$("#crimeFilters").submit();});
$("#liberty_square").click(function(){$("#crimeFilters").submit();});
$("#little_italy").click(function(){$("#crimeFilters").submit();});
$("#loch_raven").click(function(){$("#crimeFilters").submit();});
$("#locust_point").click(function(){$("#crimeFilters").submit();});
$("#locust_point_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#lower_edmondson_village").click(function(){$("#crimeFilters").submit();});
$("#lower_herring_run_park").click(function(){$("#crimeFilters").submit();});
$("#loyolanotre_dame").click(function(){$("#crimeFilters").submit();});
$("#lucille_park").click(function(){$("#crimeFilters").submit();});
$("#madison_park").click(function(){$("#crimeFilters").submit();});
$("#madison-eastend").click(function(){$("#crimeFilters").submit();});
$("#mayfield").click(function(){$("#crimeFilters").submit();});
$("#mcelderry_park").click(function(){$("#crimeFilters").submit();});
$("#medfield").click(function(){$("#crimeFilters").submit();});
$("#medford").click(function(){$("#crimeFilters").submit();});
$("#mid-govans").click(function(){$("#crimeFilters").submit();});
$("#mid-town_belvedere").click(function(){$("#crimeFilters").submit();});
$("#middle_branchreedbird_parks").click(function(){$("#crimeFilters").submit();});
$("#middle_east").click(function(){$("#crimeFilters").submit();});
$("#midtown-edmondson").click(function(){$("#crimeFilters").submit();});
$("#millhill").click(function(){$("#crimeFilters").submit();});
$("#milton-montford").click(function(){$("#crimeFilters").submit();});
$("#mondawmin").click(function(){$("#crimeFilters").submit();});
$("#montebello").click(function(){$("#crimeFilters").submit();});
$("#moravia-walther").click(function(){$("#crimeFilters").submit();});
$("#morgan_park").click(function(){$("#crimeFilters").submit();});
$("#morgan_state_university").click(function(){$("#crimeFilters").submit();});
$("#morrell_park").click(function(){$("#crimeFilters").submit();});
$("#mosher").click(function(){$("#crimeFilters").submit();});
$("#mount_holly").click(function(){$("#crimeFilters").submit();});
$("#mount_vernon").click(function(){$("#crimeFilters").submit();});
$("#mount_washington").click(function(){$("#crimeFilters").submit();});
$("#mount_winans").click(function(){$("#crimeFilters").submit();});
$("#mt_pleasant_park").click(function(){$("#crimeFilters").submit();});
$("#new_northwood").click(function(){$("#crimeFilters").submit();});
$("#new_southwestmount_clare").click(function(){$("#crimeFilters").submit();});
$("#north_harford_road").click(function(){$("#crimeFilters").submit();});
$("#north_roland_parkpoplar_hill").click(function(){$("#crimeFilters").submit();});
$("#northwest_community_action").click(function(){$("#crimeFilters").submit();});
$("#odonnell_heights").click(function(){$("#crimeFilters").submit();});
$("#oakenshawe").click(function(){$("#crimeFilters").submit();});
$("#oaklee").click(function(){$("#crimeFilters").submit();});
$("#old_goucher").click(function(){$("#crimeFilters").submit();});
$("#oldtown").click(function(){$("#crimeFilters").submit();});
$("#oliver").click(function(){$("#crimeFilters").submit();});
$("#orangeville").click(function(){$("#crimeFilters").submit();});
$("#orangeville_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#orchard_ridge").click(function(){$("#crimeFilters").submit();});
$("#original_northwood").click(function(){$("#crimeFilters").submit();});
$("#otterbein").click(function(){$("#crimeFilters").submit();});
$("#overlea").click(function(){$("#crimeFilters").submit();});
$("#panwaybraddish_avenue").click(function(){$("#crimeFilters").submit();});
$("#park_circle").click(function(){$("#crimeFilters").submit();});
$("#parklane").click(function(){$("#crimeFilters").submit();});
$("#parkside").click(function(){$("#crimeFilters").submit();});
$("#parkviewwoodbrook").click(function(){$("#crimeFilters").submit();});
$("#patterson_park").click(function(){$("#crimeFilters").submit();});
$("#patterson_park_neighborhood").click(function(){$("#crimeFilters").submit();});
$("#patterson_place").click(function(){$("#crimeFilters").submit();});
$("#pen_lucy").click(function(){$("#crimeFilters").submit();});
$("#penn_north").click(function(){$("#crimeFilters").submit();});
$("#penn-fallsway").click(function(){$("#crimeFilters").submit();});
$("#penrosefayette_street_outreach").click(function(){$("#crimeFilters").submit();});
$("#perkins_homes").click(function(){$("#crimeFilters").submit();});
$("#perring_loch").click(function(){$("#crimeFilters").submit();});
$("#pimlico_good_neighbors").click(function(){$("#crimeFilters").submit();});
$("#pleasant_view_gardens").click(function(){$("#crimeFilters").submit();});
$("#poppleton").click(function(){$("#crimeFilters").submit();});
$("#port_covington").click(function(){$("#crimeFilters").submit();});
$("#pulaski_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#purnell").click(function(){$("#crimeFilters").submit();});
$("#radnor-winston").click(function(){$("#crimeFilters").submit();});
$("#ramblewood").click(function(){$("#crimeFilters").submit();});
$("#reisterstown_station").click(function(){$("#crimeFilters").submit();});
$("#remington").click(function(){$("#crimeFilters").submit();});
$("#reservoir_hill").click(function(){$("#crimeFilters").submit();});
$("#richnor_springs").click(function(){$("#crimeFilters").submit();});
$("#ridgelys_delight").click(function(){$("#crimeFilters").submit();});
$("#riverside").click(function(){$("#crimeFilters").submit();});
$("#rognel_heights").click(function(){$("#crimeFilters").submit();});
$("#roland_park").click(function(){$("#crimeFilters").submit();});
$("#rosebank").click(function(){$("#crimeFilters").submit();});
$("#rosemont").click(function(){$("#crimeFilters").submit();});
$("#rosemont_east").click(function(){$("#crimeFilters").submit();});
$("#rosemont_homeownerstenants").click(function(){$("#crimeFilters").submit();});
$("#sabina-mattfeldt").click(function(){$("#crimeFilters").submit();});
$("#saint_agnes").click(function(){$("#crimeFilters").submit();});
$("#saint_helena").click(function(){$("#crimeFilters").submit();});
$("#saint_josephs").click(function(){$("#crimeFilters").submit();});
$("#saint_paul").click(function(){$("#crimeFilters").submit();});
$("#sandtown-winchester").click(function(){$("#crimeFilters").submit();});
$("#seton_business_park").click(function(){$("#crimeFilters").submit();});
$("#seton_hill").click(function(){$("#crimeFilters").submit();});
$("#sharp-leadenhall").click(function(){$("#crimeFilters").submit();});
$("#shipley_hill").click(function(){$("#crimeFilters").submit();});
$("#south_baltimore").click(function(){$("#crimeFilters").submit();});
$("#south_clifton_park").click(function(){$("#crimeFilters").submit();});
$("#spring_garden_industrial_area").click(function(){$("#crimeFilters").submit();});
$("#stadium_area").click(function(){$("#crimeFilters").submit();});
$("#stonewood-pentwood-winston").click(function(){$("#crimeFilters").submit();});
$("#taylor_heights").click(function(){$("#crimeFilters").submit();});
$("#ten_hills").click(function(){$("#crimeFilters").submit();});
$("#the_orchards").click(function(){$("#crimeFilters").submit();});
$("#towanda-grantley").click(function(){$("#crimeFilters").submit();});
$("#tremont").click(function(){$("#crimeFilters").submit();});
$("#tuscany-canterbury").click(function(){$("#crimeFilters").submit();});
$("#union_square").click(function(){$("#crimeFilters").submit();});
$("#university_of_maryland").click(function(){$("#crimeFilters").submit();});
$("#uplands").click(function(){$("#crimeFilters").submit();});
$("#upper_fells_point").click(function(){$("#crimeFilters").submit();});
$("#upton").click(function(){$("#crimeFilters").submit();});
$("#villages_of_homeland").click(function(){$("#crimeFilters").submit();});
$("#violetville").click(function(){$("#crimeFilters").submit();});
$("#wakefield").click(function(){$("#crimeFilters").submit();});
$("#walbrook").click(function(){$("#crimeFilters").submit();});
$("#waltherson").click(function(){$("#crimeFilters").submit();});
$("#washington_hill").click(function(){$("#crimeFilters").submit();});
$("#washington_villagepigtown").click(function(){$("#crimeFilters").submit();});
$("#waverly").click(function(){$("#crimeFilters").submit();});
$("#west_arlington").click(function(){$("#crimeFilters").submit();});
$("#west_forest_park").click(function(){$("#crimeFilters").submit();});
$("#west_hills").click(function(){$("#crimeFilters").submit();});
$("#westfield").click(function(){$("#crimeFilters").submit();});
$("#westgate").click(function(){$("#crimeFilters").submit();});
$("#westport").click(function(){$("#crimeFilters").submit();});
$("#wilhelm_park").click(function(){$("#crimeFilters").submit();});
$("#wilson_park").click(function(){$("#crimeFilters").submit();});
$("#winchester").click(function(){$("#crimeFilters").submit();});
$("#windsor_hills").click(function(){$("#crimeFilters").submit();});
$("#winston-govans").click(function(){$("#crimeFilters").submit();});
$("#woodberry").click(function(){$("#crimeFilters").submit();});
$("#woodbourne_heights").click(function(){$("#crimeFilters").submit();});
$("#woodbourne-mccabe").click(function(){$("#crimeFilters").submit();});
$("#woodmere").click(function(){$("#crimeFilters").submit();});
$("#wrenlane").click(function(){$("#crimeFilters").submit();});
$("#wyman_park").click(function(){$("#crimeFilters").submit();});
$("#wyndhurst").click(function(){$("#crimeFilters").submit();});
$("#yale_heights").click(function(){$("#crimeFilters").submit();});
$("#york-homeland").click(function(){$("#crimeFilters").submit();});

// weapons
$("#weapon_all").click(function(){$("#crimeFilters").submit();});
$("#weapon_none").click(function(){$("#crimeFilters").submit();});
$("#weapon_ignore").click(function(){$("#crimeFilters").submit();})
$("#firearm").click(function(){$("#crimeFilters").submit();});
$("#knife").click(function(){$("#crimeFilters").submit();});
$("#hands").click(function(){$("#crimeFilters").submit();});
$("#other").click(function(){$("#crimeFilters").submit();});

// districts
$("#district_all").click(function(){$("#crimeFilters").submit();});
$("#central").click(function(){$("#crimeFilters").submit();});
$("#northern").click(function(){$("#crimeFilters").submit();});
$("#southern").click(function(){$("#crimeFilters").submit();});
$("#eastern").click(function(){$("#crimeFilters").submit();});
$("#western").click(function(){$("#crimeFilters").submit();});
$("#northwestern").click(function(){$("#crimeFilters").submit();});
$("#southwestern").click(function(){$("#crimeFilters").submit();});
$("#northeastern").click(function(){$("#crimeFilters").submit();});
$("#southeastern").click(function(){$("#crimeFilters").submit();});

// months
$("#month_all").click(function(){$("#crimeFilters").submit();});
$("#january").click(function(){$("#crimeFilters").submit();});
$("#february").click(function(){$("#crimeFilters").submit();});
$("#march").click(function(){$("#crimeFilters").submit();});
$("#april").click(function(){$("#crimeFilters").submit();});
$("#may").click(function(){$("#crimeFilters").submit();});
$("#june").click(function(){$("#crimeFilters").submit();});
$("#july").click(function(){$("#crimeFilters").submit();});
$("#august").click(function(){$("#crimeFilters").submit();});
$("#september").click(function(){$("#crimeFilters").submit();});
$("#october").click(function(){$("#crimeFilters").submit();});
$("#november").click(function(){$("#crimeFilters").submit();});
$("#december").click(function(){$("#crimeFilters").submit();});

// days
$("#day_all").click(function(){$("#crimeFilters").submit();});
$("#monday").click(function(){$("#crimeFilters").submit();});
$("#tuesday").click(function(){$("#crimeFilters").submit();});
$("#wednesday").click(function(){$("#crimeFilters").submit();});
$("#thursday").click(function(){$("#crimeFilters").submit();});
$("#friday").click(function(){$("#crimeFilters").submit();});
$("#saturday").click(function(){$("#crimeFilters").submit();});
$("#sunday").click(function(){$("#crimeFilters").submit();});

});
</script>

<script>
$(function() { $("#menu").menu();});
</script>

<script>
// if the ALL checkbox is checked or unchecked, all the other boxes are checked or unchecked
 function checkAll(ele) {
     var checkboxes = document.getElementsByClassName(ele.getAttribute("class"));
     if (ele.checked) {
         for (var i = 0; i < checkboxes.length; i++) {
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = true;
             }
         }
     } else {
         for (var i = 0; i < checkboxes.length; i++) {
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = false;
             }
         }
     }
 }

// if a checkbox is unchecked, the ALL checkbox is unchecked too
function uncheckAllButton(ele) {
    	var checkboxes = document.getElementsByClassName(ele.getAttribute("class"));
	var allButton = checkboxes[0];
	if(!ele.checked) allButton.checked = false;
 }

// handle the ALL checkbox for weapon
function checkAllWeapon(ele) {
     var checkboxes = document.getElementsByClassName(ele.getAttribute("class"));
     if (ele.checked) {
		checkboxes[0].checked = true;
         for (var i = 3; i < checkboxes.length; i++) {
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = true;
             }
         }
     } else {
         for (var i = 0; i < checkboxes.length; i++) {
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = false;
             }
         }
     }
 }
// handle the NONE checkbox for weapon
function uncheckAllNone(ele){
	var checkboxes = document.getElementsByClassName(ele.getAttribute("class"));
	if(ele.checked){
	 checkboxes[0].checked = false;
		for(var x = 2; x < checkboxes.length; x++){
			checkboxes[x].checked = false;
		}
	}

}
// handled the IGNORE checkbox for weapon
function uncheckAllIgnore(ele){
	var checkboxes = document.getElementsByClassName(ele.getAttribute("class"));
	if(ele.checked){
	 checkboxes[0].checked = false;
	checkboxes[1].checked = false;
		for(var x = 3; x < checkboxes.length; x++){
			checkboxes[x].checked = false;
		}
	}
}

function checkBoxes() {
	var classes = ["day-dropdown", "month-dropdown", "neighborhood-dropdown", "district-dropdown", "crime-dropdown"];
	var index;
	for(index = 0; index < classes.length; index++){
		var checkboxes = document.getElementsByClassName(classes[index]);
		     for (var i = 0; i < checkboxes.length; i++) {
			 if (checkboxes[i].type == 'checkbox') {
			     checkboxes[i].checked = true;
			 }
		     }
	}

	var checkboxes = document.getElementsByClassName("weapon-dropdown");
	checkboxes[0].checked = true;
	     for (var i = 3; i < checkboxes.length; i++) {
		 if (checkboxes[i].type == 'checkbox') {
		     checkboxes[i].checked = true;
		 }
    	 }
}
</script>

<script>
// the toggle buttons for the map view
function toggleClusters() {
   	markerCluster.setIgnoreHidden(!markerCluster.getIgnoreHidden());
	markerCluster.repaint();
}
function toggleHeatmap() {
 	heatmap.setMap(heatmap.getMap() ? null : map);
}
</script>

</head>

<body style="margin-left:15px; padding-left: 15px;margin-right:15px; padding-right: 15px;margin-bottom:15px; padding-bottom: 15px;margin-top:2px; padding-top: 2px;" onload="checkBoxes()">
<div class="row" style="padding-top:0px">
	<div class="span12">
		<div class="col-md-6" style="padding-top:5px"> <left><img src='/css/logo.png'></left></div>

		<div class="col-md-6">
			<div class="row">
				<ul class="nav nav-tabs">
  					<li id="Map"><a >Map</a></li>
  					<li id="Table"><a>Table</a></li>
  					<li id="Chart"><a>Chart</a></li>
				</ul>
			</div>

			<div class="row" style="padding-bottom: 0px">
                        <div class="col-md-1" style="padding-left: 5px;padding-right: 5px;">
                                Location Filters:
                        </div>

<form id='crimeFilters' method="post">

		<div class="col-md-1" style="margin-left: 10px; padding-left:10px;padding-right:10px; margin-right:15px; margin-top:5px;">
					<div class="dropdown">

                                                <li class="hover_crimeli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Crime Type<span class="caret"></span></button>
						<ul class="dropdown-menu crime-menu">

<li><input type="checkbox" name="all" class="crime-dropdown" onchange="checkAll(this)" value=1 style="padding: 5px; margin: 5px;" id="crime_all" checked>ALL</input></li>
<li><input type="checkbox" name="AGG. ASSAULT" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="agg._assault">AGG. ASSAULT</input></li>
<li><input type="checkbox" name="ARSON" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="arson">ARSON</input></li>
<li><input type="checkbox" name="ASSAULT BY THREAT" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="assault_by_threat">ASSAULT BY THREAT</input></li>
<li><input type="checkbox" name="AUTO THEFT" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="auto_theft">AUTO THEFT</input></li>
<li><input type="checkbox" name="BURGLARY" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="burglary">BURGLARY</input></li>
<li><input type="checkbox" name="COMMON ASSAULT" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="common_assault">COMMON ASSAULT</input></li>
<li><input type="checkbox" name="HOMICIDE" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="homicide">HOMICIDE</input></li>
<li><input type="checkbox" name="LARCENY" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="larceny">LARCENY</input></li>
<li><input type="checkbox" name="LARCENY FROM AUTO" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="larceny_from_auto">LARCENY FROM AUTO</input></li>
<li><input type="checkbox" name="RAPE" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="rape">RAPE</input></li>
<li><input type="checkbox" name="ROBBERY - CARJACKING" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="robbery_-_carjacking">ROBBERY - CARJACKING</input></li>
<li><input type="checkbox" name="ROBBERY - COMMERCIAL" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="robbery_-_commercial">ROBBERY - COMMERCIAL</input></li>
<li><input type="checkbox" name="ROBBERY - RESIDENCE" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="robbery_-_residence">ROBBERY - RESIDENCE</input></li>
<li><input type="checkbox" name="ROBBERY - STREET" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="robbery_-_street">ROBBERY - STREET</input></li>
<li><input type="checkbox" name="SHOOTING" class="crime-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="shooting">SHOOTING</input></li>
						</ul></li>
					</div>
		</div>


		<div class="col-md-1" style="margin-left: 15px; padding-left:10px;padding-right:40px; margin-right:35px; margin-top:5px;">
				<div class="dropdown">
                                                <li class="hover_neighborhoodli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Neighborhood
						<span class="caret"></span></button>
						<ul id="menu" class="dropdown-menu neighborhood-menu">
		<li><input type="checkbox" class="neighborhood-dropdown" name="all" onchange="checkAll(this)" value=1 style="padding: 5px; margin: 5px;" id="neighborhood_all" checked>ALL</input></li>
		<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="None" value=1 style="padding: 5px; margin: 5px;" id="neighborhood_none">None Specified</input></li>

<li> A
	<ul>
		<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Abell" value=1 style="padding: 5px; margin: 5px;" id="abell">Abell</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Allendale" value=1 style="padding: 5px; margin: 5px;" id="allendale">Allendale</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Arcadia" value=1 style="padding: 5px; margin: 5px;" id="arcadia">Arcadia</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Arlington" value=1 style="padding: 5px; margin: 5px;" id="arlington">Arlington</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Armistead Gardens" value=1 style="padding: 5px; margin: 5px;" id="armistead_gardens">Armistead Gardens</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Ashburton" value=1 style="padding: 5px; margin: 5px;" id="ashburton">Ashburton</input></li>
	</ul>
</li>

<li> B
	<ul>
	<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Baltimore Highlands" value=1 style="padding: 5px; margin: 5px;" id="baltimore_highlands">Baltimore Highlands</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Barclay" value=1 style="padding: 5px; margin: 5px;" id="barclay">Barclay</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Barre Circle" value=1 style="padding: 5px; margin: 5px;" id="barre_circle">Barre Circle</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Bayview" value=1 style="padding: 5px; margin: 5px;" id="bayview">Bayview</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Beechfield" value=1 style="padding: 5px; margin: 5px;" id="beechfield">Beechfield</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Belair-Edison" value=1 style="padding: 5px; margin: 5px;" id="belair-edison">Belair-Edison</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Belair-Parkside" value=1 style="padding: 5px; margin: 5px;" id="belair-parkside">Belair-Parkside</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Bellona-Gittings" value=1 style="padding: 5px; margin: 5px;" id="bellona-gittings">Bellona-Gittings</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Belvedere" value=1 style="padding: 5px; margin: 5px;" id="belvedere">Belvedere</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Berea" value=1 style="padding: 5px; margin: 5px;" id="berea">Berea</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Better Waverly" value=1 style="padding: 5px; margin: 5px;" id="better_waverly">Better Waverly</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Beverly Hills" value=1 style="padding: 5px; margin: 5px;" id="beverly_hills">Beverly Hills</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Biddle Street" value=1 style="padding: 5px; margin: 5px;" id="biddle_street">Biddle Street</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Blythewood" value=1 style="padding: 5px; margin: 5px;" id="blythewood">Blythewood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Bolton Hill" value=1 style="padding: 5px; margin: 5px;" id="bolton_hill">Bolton Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Boyd-Booth" value=1 style="padding: 5px; margin: 5px;" id="boyd-booth">Boyd-Booth</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Brewers Hill" value=1 style="padding: 5px; margin: 5px;" id="brewers_hill">Brewers Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Bridgeview/Greenlawn" value=1 style="padding: 5px; margin: 5px;" id="bridgeviewgreenlawn">Bridgeview/Greenlawn</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Broadway East" value=1 style="padding: 5px; margin: 5px;" id="broadway_east">Broadway East</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Broening Manor" value=1 style="padding: 5px; margin: 5px;" id="broening_manor">Broening Manor</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Brooklyn" value=1 style="padding: 5px; margin: 5px;" id="brooklyn">Brooklyn</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Burleith-Leighton" value=1 style="padding: 5px; margin: 5px;" id="burleith-leighton">Burleith-Leighton</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Butcher's Hill" value=1 style="padding: 5px; margin: 5px;" id="butchers_hill">Butcher's Hill</input></li>
	</ul>
</li>
<li>C<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="CARE" value=1 style="padding: 5px; margin: 5px;" id="care">CARE</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Callaway-Garrison" value=1 style="padding: 5px; margin: 5px;" id="callaway-garrison">Callaway-Garrison</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cameron Village" value=1 style="padding: 5px; margin: 5px;" id="cameron_village">Cameron Village</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Canton" value=1 style="padding: 5px; margin: 5px;" id="canton">Canton</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Canton Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="canton_industrial_area">Canton Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Carroll - Camden Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="carroll_-_camden_industrial_area">Carroll - Camden Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Carroll Park" value=1 style="padding: 5px; margin: 5px;" id="carroll_park">Carroll Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Carroll-South Hilton" value=1 style="padding: 5px; margin: 5px;" id="carroll-south_hilton">Carroll-South Hilton</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Carrollton Ridge" value=1 style="padding: 5px; margin: 5px;" id="carrollton_ridge">Carrollton Ridge</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cedarcroft" value=1 style="padding: 5px; margin: 5px;" id="cedarcroft">Cedarcroft</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cedmont" value=1 style="padding: 5px; margin: 5px;" id="cedmont">Cedmont</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cedonia" value=1 style="padding: 5px; margin: 5px;" id="cedonia">Cedonia</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Central Forest Park" value=1 style="padding: 5px; margin: 5px;" id="central_forest_park">Central Forest Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Central Park Heights" value=1 style="padding: 5px; margin: 5px;" id="central_park_heights">Central Park Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Charles North" value=1 style="padding: 5px; margin: 5px;" id="charles_north">Charles North</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Charles Village" value=1 style="padding: 5px; margin: 5px;" id="charles_village">Charles Village</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cherry Hill" value=1 style="padding: 5px; margin: 5px;" id="cherry_hill">Cherry Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cheswolde" value=1 style="padding: 5px; margin: 5px;" id="cheswolde">Cheswolde</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Chinquapin Park" value=1 style="padding: 5px; margin: 5px;" id="chinquapin_park">Chinquapin Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Clifton Park" value=1 style="padding: 5px; margin: 5px;" id="clifton_park">Clifton Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Coldspring" value=1 style="padding: 5px; margin: 5px;" id="coldspring">Coldspring</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Coldstream Homestead Montebello" value=1 style="padding: 5px; margin: 5px;" id="coldstream_homestead_montebello">Coldstream Homestead Montebello</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Concerned Citizens Of Forest Park" value=1 style="padding: 5px; margin: 5px;" id="concerned_citizens_of_forest_park">Concerned Citizens Of Forest Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Coppin Heights/Ash-Co-East" value=1 style="padding: 5px; margin: 5px;" id="coppin_heightsash-co-east">Coppin Heights/Ash-Co-East</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cross Country" value=1 style="padding: 5px; margin: 5px;" id="cross_country">Cross Country</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cross Keys" value=1 style="padding: 5px; margin: 5px;" id="cross_keys">Cross Keys</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Curtis Bay" value=1 style="padding: 5px; margin: 5px;" id="curtis_bay">Curtis Bay</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Curtis Bay Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="curtis_bay_industrial_area">Curtis Bay Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Cylburn" value=1 style="padding: 5px; margin: 5px;" id="cylburn">Cylburn</input></li>
</ul>
	</li>
<li>D<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Darley Park" value=1 style="padding: 5px; margin: 5px;" id="darley_park">Darley Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Dickeyville" value=1 style="padding: 5px; margin: 5px;" id="dickeyville">Dickeyville</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Dolfield" value=1 style="padding: 5px; margin: 5px;" id="dolfield">Dolfield</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Dorchester" value=1 style="padding: 5px; margin: 5px;" id="dorchester">Dorchester</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Downtown" value=1 style="padding: 5px; margin: 5px;" id="downtown">Downtown</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Downtown West" value=1 style="padding: 5px; margin: 5px;" id="downtown_west">Downtown West</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Druid Heights" value=1 style="padding: 5px; margin: 5px;" id="druid_heights">Druid Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Druid Hill Park" value=1 style="padding: 5px; margin: 5px;" id="druid_hill_park">Druid Hill Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Dunbar-Broadway" value=1 style="padding: 5px; margin: 5px;" id="dunbar-broadway">Dunbar-Broadway</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Dundalk Marine Terminal" value=1 style="padding: 5px; margin: 5px;" id="dundalk_marine_terminal">Dundalk Marine Terminal</input></li>
</ul>
	</li>
<li>E<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="East Arlington" value=1 style="padding: 5px; margin: 5px;" id="east_arlington">East Arlington</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="East Baltimore Midway" value=1 style="padding: 5px; margin: 5px;" id="east_baltimore_midway">East Baltimore Midway</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Easterwood" value=1 style="padding: 5px; margin: 5px;" id="easterwood">Easterwood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Eastwood" value=1 style="padding: 5px; margin: 5px;" id="eastwood">Eastwood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Edgewood" value=1 style="padding: 5px; margin: 5px;" id="edgewood">Edgewood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Edmondson Village" value=1 style="padding: 5px; margin: 5px;" id="edmondson_village">Edmondson Village</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Ednor Gardens-Lakeside" value=1 style="padding: 5px; margin: 5px;" id="ednor_gardens-lakeside">Ednor Gardens-Lakeside</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Ellwood Park/Monument" value=1 style="padding: 5px; margin: 5px;" id="ellwood_park/monument">Ellwood Park/Monument</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Evergreen" value=1 style="padding: 5px; margin: 5px;" id="evergreen">Evergreen</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Evergreen Lawn" value=1 style="padding: 5px; margin: 5px;" id="evergreen_lawn">Evergreen Lawn</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Evesham Park" value=1 style="padding: 5px; margin: 5px;" id="evesham_park">Evesham Park</input></li>
</ul>
	</li>
<li>F<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Fairfield Area" value=1 style="padding: 5px; margin: 5px;" id="fairfield_area">Fairfield Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Fairmont" value=1 style="padding: 5px; margin: 5px;" id="fairmont">Fairmont</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Fallstaff" value=1 style="padding: 5px; margin: 5px;" id="fallstaff">Fallstaff</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Federal Hill" value=1 style="padding: 5px; margin: 5px;" id="federal_hill">Federal Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Fells Point" value=1 style="padding: 5px; margin: 5px;" id="fells_point">Fells Point</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Forest Park" value=1 style="padding: 5px; margin: 5px;" id="forest_park">Forest Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Forest Park Golf Course" value=1 style="padding: 5px; margin: 5px;" id="forest_park_golf_course">Forest Park Golf Course</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Four By Four" value=1 style="padding: 5px; margin: 5px;" id="four_by_four">Four By Four</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Frankford" value=1 style="padding: 5px; margin: 5px;" id="frankford">Frankford</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Franklin Square" value=1 style="padding: 5px; margin: 5px;" id="franklin_square">Franklin Square</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Franklintown" value=1 style="padding: 5px; margin: 5px;" id="franklintown">Franklintown</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Franklintown Road" value=1 style="padding: 5px; margin: 5px;" id="franklintown_road">Franklintown Road</input></li>
</ul>
	</li>
<li>G<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Garwyn Oaks" value=1 style="padding: 5px; margin: 5px;" id="garwyn_oaks">Garwyn Oaks</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Gay Street" value=1 style="padding: 5px; margin: 5px;" id="gay_street">Gay Street</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Glen" value=1 style="padding: 5px; margin: 5px;" id="glen">Glen</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Glen Oaks" value=1 style="padding: 5px; margin: 5px;" id="glen_oaks">Glen Oaks</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Glenham-Belhar" value=1 style="padding: 5px; margin: 5px;" id="glenham-belhar">Glenham-Belhar</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Graceland Park" value=1 style="padding: 5px; margin: 5px;" id="graceland_park">Graceland Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Greektown" value=1 style="padding: 5px; margin: 5px;" id="greektown">Greektown</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Greenmount Cemetery" value=1 style="padding: 5px; margin: 5px;" id="greenmount_cemetery">Greenmount Cemetery</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Greenmount West" value=1 style="padding: 5px; margin: 5px;" id="greenmount_west">Greenmount West</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Greenspring" value=1 style="padding: 5px; margin: 5px;" id="greenspring">Greenspring</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Grove Park" value=1 style="padding: 5px; margin: 5px;" id="grove_park">Grove Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Guilford" value=1 style="padding: 5px; margin: 5px;" id="guilford">Guilford</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Gwynns Falls" value=1 style="padding: 5px; margin: 5px;" id="gwynns_falls">Gwynns Falls</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Gwynns Falls/Leakin Park" value=1 style="padding: 5px; margin: 5px;" id="gwynns_fallsleakin_park">Gwynns Falls/Leakin Park</input></li>
</ul>
	</li>
<li>H<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hamilton Hills" value=1 style="padding: 5px; margin: 5px;" id="hamilton_hills">Hamilton Hills</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hampden" value=1 style="padding: 5px; margin: 5px;" id="hampden">Hampden</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hanlon-Longwood" value=1 style="padding: 5px; margin: 5px;" id="hanlon-longwood">Hanlon-Longwood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Harlem Park" value=1 style="padding: 5px; margin: 5px;" id="harlem_park">Harlem Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Harwood" value=1 style="padding: 5px; margin: 5px;" id="harwood">Harwood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hawkins Point" value=1 style="padding: 5px; margin: 5px;" id="hawkins_point">Hawkins Point</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Heritage Crossing" value=1 style="padding: 5px; margin: 5px;" id="heritage_crossing">Heritage Crossing</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Herring Run Park" value=1 style="padding: 5px; margin: 5px;" id="herring_run_park">Herring Run Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Highlandtown" value=1 style="padding: 5px; margin: 5px;" id="highlandtown">Highlandtown</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hillen" value=1 style="padding: 5px; margin: 5px;" id="hillen">Hillen</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hoes Heights" value=1 style="padding: 5px; margin: 5px;" id="hoes_heights">Hoes Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Holabird Industrial Park" value=1 style="padding: 5px; margin: 5px;" id="holabird_industrial_park">Holabird Industrial Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hollins Market" value=1 style="padding: 5px; margin: 5px;" id="hollins_market">Hollins Market</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Homeland" value=1 style="padding: 5px; margin: 5px;" id="homeland">Homeland</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hopkins Bayview" value=1 style="padding: 5px; margin: 5px;" id="hopkins_bayview">Hopkins Bayview</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Howard Park" value=1 style="padding: 5px; margin: 5px;" id="howard_park">Howard Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Hunting Ridge" value=1 style="padding: 5px; margin: 5px;" id="hunting_ridge">Hunting Ridge</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Idlewood" value=1 style="padding: 5px; margin: 5px;" id="idlewood">Idlewood</input></li>
</ul>
	</li>
<li>I<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Inner Harbor" value=1 style="padding: 5px; margin: 5px;" id="inner_harbor">Inner Harbor</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Irvington" value=1 style="padding: 5px; margin: 5px;" id="irvington">Irvington</input></li>
</ul>
	</li>
<li>J<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Johns Hopkins Homewood" value=1 style="padding: 5px; margin: 5px;" id="johns_hopkins_homewood">Johns Hopkins Homewood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Johnston Square" value=1 style="padding: 5px; margin: 5px;" id="johnston_square">Johnston Square</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Jones Falls Area" value=1 style="padding: 5px; margin: 5px;" id="jones_falls_area">Jones Falls Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Jonestown" value=1 style="padding: 5px; margin: 5px;" id="jonestown">Jonestown</input></li>
</ul>
	</li>
<li>K<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Kenilworth Park" value=1 style="padding: 5px; margin: 5px;" id="kenilworth_park">Kenilworth Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Kernewood" value=1 style="padding: 5px; margin: 5px;" id="kernewood">Kernewood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Keswick" value=1 style="padding: 5px; margin: 5px;" id="keswick">Keswick</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Kresson" value=1 style="padding: 5px; margin: 5px;" id="kresson">Kresson</input></li>
</ul>
	</li>
<li>L<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lake Evesham" value=1 style="padding: 5px; margin: 5px;" id="lake_evesham">Lake Evesham</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lake Walker" value=1 style="padding: 5px; margin: 5px;" id="lake_walker">Lake Walker</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lakeland" value=1 style="padding: 5px; margin: 5px;" id="lakeland">Lakeland</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Langston Hughes" value=1 style="padding: 5px; margin: 5px;" id="langston_hughes">Langston Hughes</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lauraville" value=1 style="padding: 5px; margin: 5px;" id="lauraville">Lauraville</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Levindale" value=1 style="padding: 5px; margin: 5px;" id="levindale">Levindale</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Liberty Square" value=1 style="padding: 5px; margin: 5px;" id="liberty_square">Liberty Square</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Little Italy" value=1 style="padding: 5px; margin: 5px;" id="little_italy">Little Italy</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Loch Raven" value=1 style="padding: 5px; margin: 5px;" id="loch_raven">Loch Raven</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Locust Point" value=1 style="padding: 5px; margin: 5px;" id="locust_point">Locust Point</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Locust Point Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="locust_point_industrial_area">Locust Point Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lower Edmondson Village" value=1 style="padding: 5px; margin: 5px;" id="lower_edmondson_village">Lower Edmondson Village</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lower Herring Run Park" value=1 style="padding: 5px; margin: 5px;" id="lower_herring_run_park">Lower Herring Run Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Loyola/Notre Dame" value=1 style="padding: 5px; margin: 5px;" id="loyolanotre_dame">Loyola/Notre Dame</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Lucille Park" value=1 style="padding: 5px; margin: 5px;" id="lucille_park">Lucille Park</input></li>
</ul>
	</li>
<li>M<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Madison Park" value=1 style="padding: 5px; margin: 5px;" id="madison_park">Madison Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Madison-Eastend" value=1 style="padding: 5px; margin: 5px;" id="madison-eastend">Madison-Eastend</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mayfield" value=1 style="padding: 5px; margin: 5px;" id="mayfield">Mayfield</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="McElderry Park" value=1 style="padding: 5px; margin: 5px;" id="mcelderry_park">McElderry Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Medfield" value=1 style="padding: 5px; margin: 5px;" id="medfield">Medfield</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Medford" value=1 style="padding: 5px; margin: 5px;" id="medford">Medford</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mid-Govans" value=1 style="padding: 5px; margin: 5px;" id="mid-govans">Mid-Govans</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mid-Town Belvedere" value=1 style="padding: 5px; margin: 5px;" id="mid-town_belvedere">Mid-Town Belvedere</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Middle Branch/Reedbird Parks" value=1 style="padding: 5px; margin: 5px;" id="middle_branch/reedbird_parks">Middle Branch/Reedbird Parks</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Middle East" value=1 style="padding: 5px; margin: 5px;" id="middle_east">Middle East</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Midtown-Edmondson" value=1 style="padding: 5px; margin: 5px;" id="midtown-edmondson">Midtown-Edmondson</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Millhill" value=1 style="padding: 5px; margin: 5px;" id="millhill">Millhill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Milton-Montford" value=1 style="padding: 5px; margin: 5px;" id="milton-montford">Milton-Montford</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mondawmin" value=1 style="padding: 5px; margin: 5px;" id="mondawmin">Mondawmin</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Montebello" value=1 style="padding: 5px; margin: 5px;" id="montebello">Montebello</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Moravia-Walther" value=1 style="padding: 5px; margin: 5px;" id="moravia-walther">Moravia-Walther</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Morgan Park" value=1 style="padding: 5px; margin: 5px;" id="morgan_park">Morgan Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Morgan State University" value=1 style="padding: 5px; margin: 5px;" id="morgan_state_university">Morgan State University</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Morrell Park" value=1 style="padding: 5px; margin: 5px;" id="morrell_park">Morrell Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mosher" value=1 style="padding: 5px; margin: 5px;" id="mosher">Mosher</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mount Holly" value=1 style="padding: 5px; margin: 5px;" id="mount_holly">Mount Holly</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mount Vernon" value=1 style="padding: 5px; margin: 5px;" id="mount_vernon">Mount Vernon</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mount Washington" value=1 style="padding: 5px; margin: 5px;" id="mount_washington">Mount Washington</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mount Winans" value=1 style="padding: 5px; margin: 5px;" id="mount_winans">Mount Winans</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Mt Pleasant Park" value=1 style="padding: 5px; margin: 5px;" id="mt_pleasant_park">Mt Pleasant Park</input></li>
</ul>
	</li>
<li>N<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="New Northwood" value=1 style="padding: 5px; margin: 5px;" id="new_northwood">New Northwood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="New Southwest/Mount Clare" value=1 style="padding: 5px; margin: 5px;" id="new_southwestmount_clare">New Southwest/Mount Clare</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="North Harford Road" value=1 style="padding: 5px; margin: 5px;" id="north_harford_road">North Harford Road</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="North Roland Park/Poplar Hill" value=1 style="padding: 5px; margin: 5px;" id="north_roland_parkpoplar_hill">North Roland Park/Poplar Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Northwest Community Action" value=1 style="padding: 5px; margin: 5px;" id="northwest_community_action">Northwest Community Action</input></li>
</ul>
	</li>
<li>O<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="O'Donnell Heights" value=1 style="padding: 5px; margin: 5px;" id="odonnell_heights">O'Donnell Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Oakenshawe" value=1 style="padding: 5px; margin: 5px;" id="oakenshawe">Oakenshawe</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Oaklee" value=1 style="padding: 5px; margin: 5px;" id="oaklee">Oaklee</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Old Goucher" value=1 style="padding: 5px; margin: 5px;" id="old_goucher">Old Goucher</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Oldtown" value=1 style="padding: 5px; margin: 5px;" id="oldtown">Oldtown</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Oliver" value=1 style="padding: 5px; margin: 5px;" id="oliver">Oliver</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Orangeville" value=1 style="padding: 5px; margin: 5px;" id="orangeville">Orangeville</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Orangeville Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="orangeville_industrial_area">Orangeville Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Orchard Ridge" value=1 style="padding: 5px; margin: 5px;" id="orchard_ridge">Orchard Ridge</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Original Northwood" value=1 style="padding: 5px; margin: 5px;" id="original_northwood">Original Northwood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Otterbein" value=1 style="padding: 5px; margin: 5px;" id="otterbein">Otterbein</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Overlea" value=1 style="padding: 5px; margin: 5px;" id="overlea">Overlea</input></li>
</ul>
	</li>
<li>P<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Panway/Braddish Avenue" value=1 style="padding: 5px; margin: 5px;" id="panwaybraddish_avenue">Panway/Braddish Avenue</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Park Circle" value=1 style="padding: 5px; margin: 5px;" id="park_circle">Park Circle</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Parklane" value=1 style="padding: 5px; margin: 5px;" id="parklane">Parklane</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Parkside" value=1 style="padding: 5px; margin: 5px;" id="parkside">Parkside</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Parkview/Woodbrook" value=1 style="padding: 5px; margin: 5px;" id="parkview/woodbrook">Parkview/Woodbrook</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Patterson Park" value=1 style="padding: 5px; margin: 5px;" id="patterson_park">Patterson Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Patterson Park Neighborhood" value=1 style="padding: 5px; margin: 5px;" id="patterson_park_neighborhood">Patterson Park Neighborhood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Patterson Place" value=1 style="padding: 5px; margin: 5px;" id="patterson_place">Patterson Place</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Pen Lucy" value=1 style="padding: 5px; margin: 5px;" id="pen_lucy">Pen Lucy</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Penn North" value=1 style="padding: 5px; margin: 5px;" id="penn_north">Penn North</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Penn-Fallsway" value=1 style="padding: 5px; margin: 5px;" id="penn-fallsway">Penn-Fallsway</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Penrose/Fayette Street Outreach" value=1 style="padding: 5px; margin: 5px;" id="penrose/fayette_street_outreach">Penrose/Fayette Street Outreach</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Perkins Homes" value=1 style="padding: 5px; margin: 5px;" id="perkins_homes">Perkins Homes</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Perring Loch" value=1 style="padding: 5px; margin: 5px;" id="perring_loch">Perring Loch</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Pimlico Good Neighbors" value=1 style="padding: 5px; margin: 5px;" id="pimlico_good_neighbors">Pimlico Good Neighbors</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Pleasant View Gardens" value=1 style="padding: 5px; margin: 5px;" id="pleasant_view_gardens">Pleasant View Gardens</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Poppleton" value=1 style="padding: 5px; margin: 5px;" id="poppleton">Poppleton</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Port Covington" value=1 style="padding: 5px; margin: 5px;" id="port_covington">Port Covington</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Pulaski Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="pulaski_industrial_area">Pulaski Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Purnell" value=1 style="padding: 5px; margin: 5px;" id="purnell">Purnell</input></li>
</ul>
	</li>

<li>R<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Radnor-Winston" value=1 style="padding: 5px; margin: 5px;" id="radnor-winston">Radnor-Winston</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Ramblewood" value=1 style="padding: 5px; margin: 5px;" id="ramblewood">Ramblewood</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Reisterstown Station" value=1 style="padding: 5px; margin: 5px;" id="reisterstown_station">Reisterstown Station</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Remington" value=1 style="padding: 5px; margin: 5px;" id="remington">Remington</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Reservoir Hill" value=1 style="padding: 5px; margin: 5px;" id="reservoir_hill">Reservoir Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Richnor Springs" value=1 style="padding: 5px; margin: 5px;" id="richnor_springs">Richnor Springs</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Ridgely's Delight" value=1 style="padding: 5px; margin: 5px;" id="ridgelys_delight">Ridgely's Delight</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Riverside" value=1 style="padding: 5px; margin: 5px;" id="riverside">Riverside</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Rognel Heights" value=1 style="padding: 5px; margin: 5px;" id="rognel_heights">Rognel Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Roland Park" value=1 style="padding: 5px; margin: 5px;" id="roland_park">Roland Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Rosebank" value=1 style="padding: 5px; margin: 5px;" id="rosebank">Rosebank</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Rosemont" value=1 style="padding: 5px; margin: 5px;" id="rosemont">Rosemont</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Rosemont East" value=1 style="padding: 5px; margin: 5px;" id="rosemont_east">Rosemont East</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Rosemont Homeowners/Tenants" value=1 style="padding: 5px; margin: 5px;" id="rosemont_homeowners/tenants">Rosemont Homeowners/Tenants</input></li>
</ul>
	</li>
<li>S<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Sabina-Mattfeldt" value=1 style="padding: 5px; margin: 5px;" id="sabina-mattfeldt">Sabina-Mattfeldt</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Saint Agnes" value=1 style="padding: 5px; margin: 5px;" id="saint_agnes">Saint Agnes</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Saint Helena" value=1 style="padding: 5px; margin: 5px;" id="saint_helena">Saint Helena</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Saint Josephs" value=1 style="padding: 5px; margin: 5px;" id="saint_josephs">Saint Josephs</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Saint Paul" value=1 style="padding: 5px; margin: 5px;" id="saint_paul">Saint Paul</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Sandtown-Winchester" value=1 style="padding: 5px; margin: 5px;" id="sandtown-winchester">Sandtown-Winchester</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Seton Business Park" value=1 style="padding: 5px; margin: 5px;" id="seton_business_park">Seton Business Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Seton Hill" value=1 style="padding: 5px; margin: 5px;" id="seton_hill">Seton Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Sharp-Leadenhall" value=1 style="padding: 5px; margin: 5px;" id="sharp-leadenhall">Sharp-Leadenhall</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Shipley Hill" value=1 style="padding: 5px; margin: 5px;" id="shipley_hill">Shipley Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="South Baltimore" value=1 style="padding: 5px; margin: 5px;" id="south_baltimore">South Baltimore</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="South Clifton Park" value=1 style="padding: 5px; margin: 5px;" id="south_clifton_park">South Clifton Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Spring Garden Industrial Area" value=1 style="padding: 5px; margin: 5px;" id="spring_garden_industrial_area">Spring Garden Industrial Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Stadium Area" value=1 style="padding: 5px; margin: 5px;" id="stadium_area">Stadium Area</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Stonewood-Pentwood-Winston" value=1 style="padding: 5px; margin: 5px;" id="stonewood-pentwood-winston">Stonewood-Pentwood-Winston</input></li>
</ul>
	</li>
<li>T<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Taylor Heights" value=1 style="padding: 5px; margin: 5px;" id="taylor_heights">Taylor Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Ten Hills" value=1 style="padding: 5px; margin: 5px;" id="ten_hills">Ten Hills</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="The Orchards" value=1 style="padding: 5px; margin: 5px;" id="the_orchards">The Orchards</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Towanda-Grantley" value=1 style="padding: 5px; margin: 5px;" id="towanda-grantley">Towanda-Grantley</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Tremont" value=1 style="padding: 5px; margin: 5px;" id="tremont">Tremont</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Tuscany-Canterbury" value=1 style="padding: 5px; margin: 5px;" id="tuscany-canterbury">Tuscany-Canterbury</input></li>
</ul>
	</li>
<li>U<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Union Square" value=1 style="padding: 5px; margin: 5px;" id="union_square">Union Square</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="University Of Maryland" value=1 style="padding: 5px; margin: 5px;" id="university_of_maryland">University Of Maryland</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Uplands" value=1 style="padding: 5px; margin: 5px;" id="uplands">Uplands</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Upper Fells Point" value=1 style="padding: 5px; margin: 5px;" id="upper_fells_point">Upper Fells Point</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Upton" value=1 style="padding: 5px; margin: 5px;" id="upton">Upton</input></li>
</ul>
	</li>
<li>V<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Villages Of Homeland" value=1 style="padding: 5px; margin: 5px;" id="villages_of_homeland">Villages Of Homeland</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Violetville" value=1 style="padding: 5px; margin: 5px;" id="violetville">Violetville</input></li>
</ul>
	</li>
<li>W<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Wakefield" value=1 style="padding: 5px; margin: 5px;" id="wakefield">Wakefield</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Walbrook" value=1 style="padding: 5px; margin: 5px;" id="walbrook">Walbrook</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Waltherson" value=1 style="padding: 5px; margin: 5px;" id="waltherson">Waltherson</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Washington Hill" value=1 style="padding: 5px; margin: 5px;" id="washington_hill">Washington Hill</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Washington Village/Pigtown" value=1 style="padding: 5px; margin: 5px;" id="washington_village/pigtown">Washington Village/Pigtown</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Waverly" value=1 style="padding: 5px; margin: 5px;" id="waverly">Waverly</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="West Arlington" value=1 style="padding: 5px; margin: 5px;" id="west_arlington">West Arlington</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="West Forest Park" value=1 style="padding: 5px; margin: 5px;" id="west_forest_park">West Forest Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="West Hills" value=1 style="padding: 5px; margin: 5px;" id="west_hills">West Hills</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Westfield" value=1 style="padding: 5px; margin: 5px;" id="westfield">Westfield</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Westgate" value=1 style="padding: 5px; margin: 5px;" id="westgate">Westgate</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Westport" value=1 style="padding: 5px; margin: 5px;" id="westport">Westport</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Wilhelm Park" value=1 style="padding: 5px; margin: 5px;" id="wilhelm_park">Wilhelm Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Wilson Park" value=1 style="padding: 5px; margin: 5px;" id="wilson_park">Wilson Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Winchester" value=1 style="padding: 5px; margin: 5px;" id="winchester">Winchester</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Windsor Hills" value=1 style="padding: 5px; margin: 5px;" id="windsor_hills">Windsor Hills</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Winston-Govans" value=1 style="padding: 5px; margin: 5px;" id="winston-govans">Winston-Govans</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Woodberry" value=1 style="padding: 5px; margin: 5px;" id="woodberry">Woodberry</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Woodbourne Heights" value=1 style="padding: 5px; margin: 5px;" id="woodbourne_heights">Woodbourne Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Woodbourne-McCabe" value=1 style="padding: 5px; margin: 5px;" id="woodbourne-mccabe">Woodbourne-McCabe</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Woodmere" value=1 style="padding: 5px; margin: 5px;" id="woodmere">Woodmere</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Wrenlane" value=1 style="padding: 5px; margin: 5px;" id="wrenlane">Wrenlane</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Wyman Park" value=1 style="padding: 5px; margin: 5px;" id="wyman_park">Wyman Park</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Wyndhurst" value=1 style="padding: 5px; margin: 5px;" id="wyndhurst">Wyndhurst</input></li>
</ul>
	</li>

<li>Y<ul>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="Yale Heights" value=1 style="padding: 5px; margin: 5px;" id="yale_heights">Yale Heights</input></li>
<li><input type="checkbox" class="neighborhood-dropdown" onchange="uncheckAllButton(this)" name="York-Homeland" value=1 style="padding: 5px; margin: 5px;" id="york-homeland">York-Homeland</input></li>
</ul>
	</li>

</ul></li>

				</div> <!-- end neighborhood dropdown-->
		</div> <!-- end neighborhood div -->
                <script>
                //neighborhood dropdown bug fix
                $('ul.neighborhood-menu').slideDown(0);
                $('ul.neighborhood-menu').slideUp(0);
                </script>
	<div class="col-md-1" style="margin-left: 10px; padding-left:10px;padding-right:10px; margin-right:6px; margin-top:5px;">
					<div class="dropdown">
                                                <li class="hover_weaponli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Weapon
						<span class="caret"></span></button>
						<ul class="dropdown-menu weapon-menu">

			<li><input type="checkbox" name="all" class="weapon-dropdown" onchange="checkAllWeapon(this)" value=1 style="padding: 5px; margin: 5px;" id="weapon_all" checked>ALL</input></li>
			<li><input type="checkbox" name="weapon_none" class="weapon-dropdown" onchange="uncheckAllNone(this)" value=1 style="padding: 5px; margin: 5px;" id="weapon_none">NONE</input></li>
<li><input type="checkbox" name="weapon_ignore" class="weapon-dropdown" onchange="uncheckAllIgnore(this)" value=1 style="padding: 5px; margin: 5px;" id="weapon_ignore">IGNORE FIELD</input></li>
			<li><input type="checkbox" name="FIREARM" class="weapon-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="firearm">FIREARM</input></li>
			<li><input type="checkbox" name="OTHER" class="weapon-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="other">OTHER</input></li>
			<li><input type="checkbox" name="KNIFE" class="weapon-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="knife">KNIFE</input></li>
			<li><input type="checkbox" name="HANDS" class="weapon-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="hands">HANDS</input></li>

                </ul></li>
					</div>
		</div>

<div class="col-md-1" style="margin-left: 10px; padding-left:10px;padding-right:10px; margin-right:15px; margin-top:5px;">
					<div class="dropdown">
                                                <li class="hover_districtli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">District
						<span class="caret"></span></button>
						<ul class="dropdown-menu district-menu">
			<li><input type="checkbox" name="all" class="district-dropdown"
	onchange="checkAll(this)" value=1 style="padding: 5px; margin: 5px;" id="district_all" checked>ALL</input></li>
			<li><input type="checkbox" name="CENTRAL" class="district-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="central">CENTRAL</input></li>
			<li><input type="checkbox" name="NORTHERN"  class="district-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="northern">NORTHERN</input></li>
			<li><input type="checkbox" name="SOUTHERN" class="district-dropdown"  onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="southern">SOUTHERN</input></li>
			<li><input type="checkbox" name="EASTERN" class="district-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="eastern">EASTERN</input></li>
			<li><input type="checkbox" name="NORTHEASTERN"  class="district-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="northeastern">NORTHEASTERN</input></li>
			<li><input type="checkbox" name="SOUTHEASTERN" class="district-dropdown"  onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="southeastern">SOUTHEASTERN</input></li>
			<li><input type="checkbox" name="NORTHWESTERN"  class="district-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="northwestern">NORTHWESTERN</input></li>
			<li><input type="checkbox" name="SOUTHWESTERN" class="district-dropdown"  onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="southwestern">SOUTHWESTERN</input></li>


                </ul></li>
					</div>
		</div>

			</div> <!-- end of row-->


                        <div class="row" style="padding-bottom: 0px">
                        <div class="col-md-1" style="padding: 4px">
                                Time Filters:
                        </div>
<div class="col-md-1" style="margin-left: 10px; padding-left:10px;padding-right:10px; margin-right:2px; margin-top:5px;">
					<div class="dropdown">
                                                <li class="hover_monthli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Month				<span class="caret"></span></button>
						<ul class="dropdown-menu month-menu">
<li><input type="checkbox" name="all" class="month-dropdown" onchange="checkAll(this)" value=1 style="padding: 5px; margin: 5px;" id="month_all" checked>ALL</input></li>
<li><input type="checkbox" name="January" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="january">January</input></li>
<li><input type="checkbox" name="February" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="february">February</input></li>
<li><input type="checkbox" name="March" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="march">March</input></li>
<li><input type="checkbox" name="April" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="april">April</input></li>
<li><input type="checkbox" name="May" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="may">May</input></li>
<li><input type="checkbox" name="June" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="june">June</input></li>
<li><input type="checkbox" name="July" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="july">July</input></li>
<li><input type="checkbox" name="August" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="august">August</input></li>
<li><input type="checkbox" name="September" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="september">September</input></li>
<li><input type="checkbox" name="October" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="october">October</input></li>
<li><input type="checkbox" name="November" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="november">November</input></li>
<li><input type="checkbox" name="December" class="month-dropdown" onchange="uncheckAllButton(this)" value=1 style="padding: 5px; margin: 5px;" id="december">December</input></li>
						</ul></li>
					</div>
		</div>



<div class="col-md-1" style="margin-left: 0px; padding-left:10px;padding-right:0px; margin-right:-10px; margin-top:5px;">
					<div class="dropdown">
                                                <li class="hover_dayli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Day				<span class="caret"></span></button>
						<ul class="dropdown-menu day-menu">
<li><input type="checkbox" name="all" class="day-dropdown" onchange="checkAll(this)" value=1 style="padding: 5px; margin: 5px;" id="day_all" checked>ALL</input></li>
<li><input type="checkbox" name="Monday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="monday">Monday</input></li>
<li><input type="checkbox" name="Tuesday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="tuesday">Tuesday</input></li>
<li><input type="checkbox" name="Wednesday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="wednesday">Wednesday</input></li>
<li><input type="checkbox" name="Thursday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="thursday">Thursday</input></li>
<li><input type="checkbox" name="Friday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="friday">Friday</input></li>
<li><input type="checkbox" name="Saturday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="saturday">Saturday</input></li>
<li><input type="checkbox" name="Sunday" onchange="uncheckAllButton(this)" class="day-dropdown" value=1 style="padding: 5px; margin: 5px;" id="sunday">Sunday</input></li>
						</ul></li>
					</div>
		</div>


<div class="col-md-1" style="margin-left: 0px; padding-left:10px;padding-right:0px; margin-right:-7px; margin-top:5px;">
					<div class="dropdown">
					<li class="hover_hourli">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Hour<span class="caret"></span></button>
						<ul class="dropdown-menu hour-menu"> <li>
<li><input type="checkbox" name="hour_all" value=1 style="padding: 5px; margin: 5px;" id="1"  onchange="checkAllButton(this)">All</input></li>
<li><input type="checkbox" name="0" value=1 style="padding: 5px; margin: 5px;" id="0"  onchange="uncheckAllButton(this)">0</input></li>
<li><input type="checkbox" name="1" value=1 style="padding: 5px; margin: 5px;" id="1"  onchange="uncheckAllButton(this)">1</input></li>
<li><input type="checkbox" name="2" value=1 style="padding: 5px; margin: 5px;" id="2"  onchange="uncheckAllButton(this)">2</input></li>
<li><input type="checkbox" name="3" value=1 style="padding: 5px; margin: 5px;" id="3"  onchange="uncheckAllButton(this)">3</input></li>
<li><input type="checkbox" name="4" value=1 style="padding: 5px; margin: 5px;" id="4"  onchange="uncheckAllButton(this)">4</input></li>
<li><input type="checkbox" name="5" value=1 style="padding: 5px; margin: 5px;" id="5"  onchange="uncheckAllButton(this)">5</input></li>
<li><input type="checkbox" name="6" value=1 style="padding: 5px; margin: 5px;" id="6"  onchange="uncheckAllButton(this)">6</input></li>
<li><input type="checkbox" name="7" value=1 style="padding: 5px; margin: 5px;" id="7"  onchange="uncheckAllButton(this)">7</input></li>
<li><input type="checkbox" name="8" value=1 style="padding: 5px; margin: 5px;" id="8"  onchange="uncheckAllButton(this)">8</input></li>
<li><input type="checkbox" name="9" value=1 style="padding: 5px; margin: 5px;" id="9"  onchange="uncheckAllButton(this)">9</input></li>
<li><input type="checkbox" name="10" value=1 style="padding: 5px; margin: 5px;" id="10"  onchange="uncheckAllButton(this)">10</input></li>
<li><input type="checkbox" name="11" value=1 style="padding: 5px; margin: 5px;" id="11"  onchange="uncheckAllButton(this)">11</input></li>
<li><input type="checkbox" name="12" value=1 style="padding: 5px; margin: 5px;" id="12"  onchange="uncheckAllButton(this)">12</input></li>
<li><input type="checkbox" name="13" value=1 style="padding: 5px; margin: 5px;" id="13"  onchange="uncheckAllButton(this)">13</input></li>
<li><input type="checkbox" name="14" value=1 style="padding: 5px; margin: 5px;" id="14"  onchange="uncheckAllButton(this)">14</input></li>
<li><input type="checkbox" name="15" value=1 style="padding: 5px; margin: 5px;" id="15"  onchange="uncheckAllButton(this)">15</input></li>
<li><input type="checkbox" name="16" value=1 style="padding: 5px; margin: 5px;" id="16"  onchange="uncheckAllButton(this)">16</input></li>
<li><input type="checkbox" name="17" value=1 style="padding: 5px; margin: 5px;" id="17"  onchange="uncheckAllButton(this)">17</input></li>
<li><input type="checkbox" name="18" value=1 style="padding: 5px; margin: 5px;" id="18"  onchange="uncheckAllButton(this)">18</input></li>
<li><input type="checkbox" name="19" value=1 style="padding: 5px; margin: 5px;" id="19"  onchange="uncheckAllButton(this)">19</input></li>
<li><input type="checkbox" name="20" value=1 style="padding: 5px; margin: 5px;" id="20"  onchange="uncheckAllButton(this)">20</input></li>
<li><input type="checkbox" name="21" value=1 style="padding: 5px; margin: 5px;" id="21"  onchange="uncheckAllButton(this)">21</input></li>
<li><input type="checkbox" name="22" value=1 style="padding: 5px; margin: 5px;" id="22"  onchange="uncheckAllButton(this)">22</input></li>
<li><input type="checkbox" name="23" value=1 style="padding: 5px; margin: 5px;" id="23"  onchange="uncheckAllButton(this)">23</input></li>
						</ul></li>
					</div>
		</div>

<div class="col-md-1" style="margin-left: -3px; padding-right:10px; margin-right:0px; margin-top:5px;">

<div class="dropdown">
<li class="hover_dateRangeli">
    <button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">Custom Date Range
      <span class="caret"></span></button>
    <ul class="dropdown-menu dateRange-menu" id="links">
      <li><a class="dateRangeLink" href="#">New...</a></li>
      <li class="divider"></li>
    </ul>
    </li>
  </div>

</div>

<div class="col-md-1" style="margin-left: 83px; padding-right:10px; margin-right:20px; margin-top:5px;">
<div class="dropdown">
<li class="hover_customQueryli">
<button class="btn btn-sm btn-success dropdown-toggle" type="button" data-toggle="dropdown">Custom Query
<span class="caret"></span></button>
<ul class="dropdown-menu customQuery-menu" id="customQueryLinks">
<li><a class="customQueryLink" href="#">New...</a></li>
<li class="divider"></li>
</ul>
</li>
</div>
</div>
				<input type='hidden' id='min' name='min' value='1262304000'>
				<input type='hidden' id='max' name='max' value='1483142400'>
				<input type='hidden' value='submit'>
                </div><!-- end of 2nd row-->
                </div><!-- end of last col in logo span-->
        </div> <!--end of logo span -->
</div> <!-- end of logo row -->
</form>

<script>
function toggleLegend(){

        if($("#draggable").is(":visible")){
                $("#draggable").hide();
        }
        else{
                $("#draggable").show();
        }
}

//define hover over options for dropdown menus
$(".hover_crimeli").hover(
  function () {
     $('ul.crime-menu').slideDown(0);
  },
  function () {
     $('ul.crime-menu').slideUp(0);
  }
);

$(".hover_neighborhoodli").hover(
  function () {
     $('ul.neighborhood-menu').slideDown(0);
  },
  function () {
     $('ul.neighborhood-menu').slideUp(0);
  }
);

$(".hover_weaponli").hover(
  function () {
     $('ul.weapon-menu').slideDown(0);
  },
  function () {
     $('ul.weapon-menu').slideUp(0);
  }
);

$(".hover_districtli").hover(
  function () {
     $('ul.district-menu').slideDown(0);
  },
  function () {
     $('ul.district-menu').slideUp(0);
  }
);

$(".hover_monthli").hover(
  function () {
     $('ul.month-menu').slideDown(0);
  },
  function () {
     $('ul.month-menu').slideUp(0);
  }
);

$(".hover_dayli").hover(
  function () {
     $('ul.day-menu').slideDown(0);
  },
  function () {
     $('ul.day-menu').slideUp(0);
  }
);

$(".hover_hourli").hover(
	function () {
		$('ul.hour-menu').slideDown(0);
	},
	function () {
		$('ul.hour-menu').slideUp(0);
	}
);

$(".hover_dateRangeli").hover(
  function () {
     $('ul.dateRange-menu').slideDown(0);
  },
  function () {
     $('ul.dateRange-menu').slideUp(0);
  }
);

$(".hover_customQueryli").hover(
  function () {
     $('ul.customQuery-menu').slideDown(0);
  },
  function () {
     $('ul.customQuery-menu').slideUp(0);
  }
);
</script>

<!-- set up the map view -->
<div id="dateSlider" style="margin-bottom:5px;"> </div>
<div id="map" style="height:80%; width:100%;"></div>

<script>
// initialize width of the map
$("#map").css("width", $("#dateSlider").width());

// and resize the map everytime the window is resized
$(window).resize(function() {
	$("#map").css("width", $("#dateSlider").width());
});
</script>

<div id='floating-panel'>
     <button id="toggleClustersButton" class="btn btn-xs btn-primary" type="button" onclick="toggleClusters()">Toggle Clusters</button>
     <button id="toggleHeatmapButton" class="btn btn-xs btn-primary" type="button" onclick="toggleHeatmap()">Toggle Heatmap</button>
     <button id="toggleCirclesButton" class="btn btn-xs btn-primary" type="button" onclick="circleTest()">Toggle Circles</button>
     <button id="toggleLegendButton" class="btn btn-xs btn-primary" type="button" onclick="toggleLegend()">Toggle Legend</button>
     <div id="draggable" style="display:none" class="ui-widget-content">
   <b><p>Cluster Colors: </p></b>
   <p>Blue: 2-9 crimes</p>
   <p>Yellow: 10-99 crimes</p>
   <p>Red: 100-999 crimes</p>
   <p>Pink: 1000+ crimes</p>
 </div>
<style>
#map { position: absolute; }
#toggleClustersButton { position: relative; top: 80px; left: 10px; z-index: 99; }
#toggleHeatmapButton { position: relative; top: 110px; left: -90px; }
#toggleCirclesButton { position: relative; top: 140px; left: -195px; }
#toggleLegendButton { position: relative; top: 170px; left: -287px; }
</style>
</div>
<script>
$(function() {
    $( "#draggable" ).draggable();
  });
  </script>

<!-- set up the table view -->
<div id="table" class='table table-striped' style={{bottleData[1]['table']}} width="100%">
	<table id="myTable" class="table table-striped" width="100%">
		<thead>
			<th>Date</th>
			<th>Time</th>
			<th>Crime</th>
			<th>Weapon</th>
			<th>Neighborhood</th>
                        <th>Lattitude</th>
                        <th>Longitude</th>
		</thead>
		<tbody>
			<div name='tableInner' id='tableInner'></div>
			<!--Print out query data in a nice table-->
			% for item in bottleData[0]:
                                % date = str(item['date']).title()
                                % time = str(item['time']).title()
                                % crime = str(item['crime']).title()
                                % weapon = str(item['weapon']).title()
                                % neighborhood = str(item['neighborhood']).title()
				<tr>
					<td>{{ date }} </td>
					<td>{{ time }} </td>
					<td>{{ crime }} </td>
					<td>{{ weapon }} </td>
					<td>{{ neighborhood }} </td>
                                        <td>{{ item['lattitude'] }} </td>
					<td>{{ item['longitude'] }} </td>
				</tr>
			% end
			</div>
		</tbody>
	</table>
</div> <!-- ends table-->

<div id="chart" style={{bottleData[1]['chart']}}>
	        <center>
<!--          	  <button id = "All type" onclick="toggle_div_function('crime_line_chart'); toggle_div_function('neighborhood_line_chart'); toggle_div_function('weapon_line_chart'); toggle_div_function('district_line_chart'); toggle_div_function('crime_pie_chart'); toggle_div_function('neighborhood_pie_chart'); toggle_div_function('weapon_pie_chart'); toggle_div_function('district_pie_chart');">Toggle All</button>    -->
          	  <!--<button id = "All type" onclick="toggle_div_function('all_graphs_bars'); toggle_div_function('crime_pie_chart'); toggle_div_function('neighborhood_pie_chart'); toggle_div_function('weapon_pie_chart'); toggle_div_function('district_pie_chart');">Toggle All</button>-->
          	  <div><button class="btn btn-xs btn-primary" id = "All_graph/bars" onclick="toggle_div_function('all_graphs_bars');toggle_div_function('pie_container'); toggle_div_function('button_pie');">Toggle Bar Graph/Pie Charts</button></div>
                  <div></div>
		  <div></div>
     
                  <div style = "display: none; padding-top: 10px;" id = "button_pie">
		  <button class="btn btn-xs btn-primary" id = "crime_pie">Crime Pie Chart</button>
		  <button class="btn btn-xs btn-primary" id = "neighborhood_pie">Neighborhood Pie Chart</button>
		  <button class="btn btn-xs btn-primary" id = "weapon_pie">Weapon Pie Chart</button>
		  <button class="btn btn-xs btn-primary" id = "district_pie">District Pie Chart</button>
		  </div>

		</center>

                <div id="all_graphs_bars">
                <center>
                <div style="width:90%; " id="overall_bar_chart"></div>
                <div style="width:90%; " id="crime_bar_chart"></div>
                <div style="width:90%; " id="neighborhood_bar_chart"></div>
                <div style="width:90%; " id="weapon_bar_chart"></div>
                <div style="width:90%; " id="district_bar_chart"></div>
                </center>
                </div>

                <div id="pie_container" style="display:none">
                <div class="pies" style="width:100%; height: 75%;" id="crime_pie_chart"></div>
                <div class="pies" style="width:100%; height: 75%; display:none;" id="neighborhood_pie_chart"></div>
                <div class="pies" style="width:100%; height: 75%; display:none;" id="weapon_pie_chart"></div>
                <div class="pies" style="width:100%; height: 75%; display:none;" id="district_pie_chart"></div>
                </center>
                </div>
        </div>

        <div class="modalLoad"></div>
	<script>

	$("#crime_pie").click(function(){
     		$("#crime_pie_chart").show();
     		$("#neighborhood_pie_chart").hide();
     		$("#weapon_pie_chart").hide();
     		$("#district_pie_chart").hide();
	});
	$("#neighborhood_pie").click(function(){
     		$("#crime_pie_chart").hide();
     		$("#neighborhood_pie_chart").show();
     		$("#weapon_pie_chart").hide();
     		$("#district_pie_chart").hide();
	});
	$("#weapon_pie").click(function(){
     		$("#crime_pie_chart").hide();
     		$("#neighborhood_pie_chart").hide();
     		$("#weapon_pie_chart").show();
     		$("#district_pie_chart").hide();
	});
	$("#district_pie").click(function(){
     		$("#crime_pie_chart").hide();
     		$("#neighborhood_pie_chart").hide();
     		$("#weapon_pie_chart").hide();
     		$("#district_pie_chart").show();
	});

        $('#switchPie').click(function() {
                var visibleBox = $('#pie_container .pies:visible');
                visibleBox.hide();
                var nextToShow = $(visibleBox).next('.pies:hidden');
                if (nextToShow.length > 0) {
                        nextToShow.show();
                } else {
                        $('#pie_container .pies:hidden:first').show();
                }
                return false;
        });
                $("#toggle").click(function(){
                    $("#overall_line_chart").toggle();
                    $("#crime_line_chart").toggle();
                    $("#neighborhood_line_chart").toggle();
                    $("#weapon_line_chart").toggle();
                    $("#district_line_chart").toggle();

                    $("#overall_bar_chart").toggle();
                    $("#crime_bar_chart").toggle();
                    $("#neighborhood_bar_chart").toggle();
                    $("#weapon_bar_chart").toggle();
                    $("#district_bar_chart").toggle();
                });


function toggle_div_function(id){

    var div_element = document.getElementById(id);
    if(div_element.style.display == 'none'){
        div_element.style.display = 'block';
    }
    else{
        div_element.style.display = 'none';
    }
}

function buildTable(){

	$("#table").html("");
	var count = Object.keys(data[0]).length;
	console.log(count);
	var tableStr ="";

	tableStr+="<table id='myTable' class='table table-striped' width='100%'><thead><th>Date</th><th>Time</th><th>Crime</th><th>Weapon</th><th>Neighborhood</th><th>Lattitude</th><th>Longitude</th></thead><tbody>";

 	//print(data[0][1]['date'])
        %print(bottleData[0])

	for(var i = 0 ; i < count; i++){

		//document.write(data[0][i]);
		tableStr += "<tr><td>"+data[0][i]['date'].substr(0,10)+" </td>"+"<td>"+data[0][i]['time']+" </td>"+"<td>"+toTitleCase(data[0][i]['crime'])+" </td>"+"<td>"+toTitleCase(data[0][i]['weapon'])+" </td>"+"<td>"+data[0][i]['neighborhood']+" </td>"+"<td>"+data[0][i]['lattitude']+" </td>"+"<td>"+data[0][i]['longitude']+" </td>"+"</tr>";
	}

	tableStr+="</tbody></table>";

	$("#table").html(tableStr);
$("#myTable").DataTable();
}
function updateViewData(json){
	data = json;
	console.log(data);

//alert("First lat is: " +JSON.stringify(data[0][0]['lattitude']));
//rebuild table on ajax call
buildTable();

//rebuild map on ajax call
updateMap();

//update and draw the chart
drawChart();
}
</script>

<script>
var map;

function isInArray(value, array){
return(array.indexOf(value) > -1);
}

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: {lat: 39.291910, lng:  -76.616062},
    mapTypeId: google.maps.MapTypeId.MAP,
    scaleControl: true
  });

// set up the marker clusters
var markers = [];

var allpoints = getPoints();
for (var i = 0; i < allpoints.length; i++)
{
	var marker = new google.maps.Marker({'position': allpoints[i], map: map, visible: false});
	markers.push(marker);
}
markerCluster = new MarkerClusterer(map, markers);
markerCluster.setTitle("total data points = " + markerCluster.getTotalMarkers());
markerCluster.setAverageCenter(true);
markerCluster.setGridSize(100); // the bigger the arg, the fewer the clusters

//set the info box for each clusters
for (var i = 0; i <markerCluster.getTotalClusters();++i){
        markerCluster.getClusters()[i].title = 'The Total Amount Of Crimes In This Cluster: '+ markerCluster.getClusters()[i].getTotalMarkers();
}

  heatmap = new google.maps.visualization.HeatmapLayer({
    data: getPoints(),
    map: map
  });

	changeGradient();
        google.maps.event.addListener(markerCluster, 'mouseover', function (c) {
            if(c.clusterIcon_.div_){
        /*            var lat = "";
                for(var j = 0; j < c.getSize(); j++){
                        //lat = c.getMarkers()[j].getPosition().lat();

                        data.forEach(function(entry) {
                                if (entry.lattitude == c.getMarkers()[j].getPosition().lat()  && entry.longitude == c.getMarkers()[j].getPosition().lng()) {
                                        lat+="found match\n";
                                }
                        });
                }
                alert(lat);*/
                c.clusterIcon_.div_.title =  c.getSize() + ' crimes in this area';
            }
        });
}

// set up the circle view
var circles = [];
var firstCircleRun = true;

function circleTest() {

console.log("Number of clusters: "+ markerCluster.getTotalClusters());
if (circles.length)
{
        for (i = 0; i < circles.length; ++i)
                circles[i].setMap(null);
        circles = [];
}
else
 {
        if (firstCircleRun){
        for (i = 0;i < markerCluster.getTotalClusters(); ++i){
                console.log("Pushing circles from first run");
                circles.push(new google.maps.Circle({
                        map:map,
                        radius:1000,
                        fillColor:"#000000",
                        center: markerCluster.getClusters()[i].getCenter()
                }));
        }
        firstCircleRun = false;
        console.log("CenterTest: " + markerCluster.getClusters()[0].getCenter());
        }else{
                for (i = 0;i < markerCluster.getTotalClusters(); ++i){
                        circles[i] = new google.maps.Circle({
                                map:map,
                                radius:1000,
                                fillColor:"#000000",
                                center: markerCluster.getClusters()[i].getCenter()
                        });
        }
}
}
}

function updateMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: map.getZoom(),
    center: map.getCenter(),
    mapTypeId: google.maps.MapTypeId.MAP,
    scaleControl: true
  });

  var markers = [];

  var allpoints = updatePoints();
  for (var i = 0; i < allpoints.length; i++)
  {
  	var marker = new google.maps.Marker({'position': allpoints[i], map: map, visible: false});
  	markers.push(marker);
  }
var saveHidden = markerCluster.getIgnoreHidden();
  markerCluster = new MarkerClusterer(map, markers);
  markerCluster.setTitle("total markers = " + markerCluster.getTotalMarkers());
  markerCluster.setAverageCenter(true);
  markerCluster.setGridSize(100); // the bigger the arg, the fewer the clusters
  markerCluster.setIgnoreHidden(saveHidden);

var saveHeatmap = heatmap.getMap();
  heatmap = new google.maps.visualization.HeatmapLayer({
    data: updatePoints(),
    map: map
  });
// maintain the previous visibility of the heatmap
heatmap.setMap(saveHeatmap ? map : null);

	changeGradient();
        google.maps.event.addListener(markerCluster, 'mouseover', function (c) {
            if(c.clusterIcon_.div_){
                  /*  var lat = "";
                    var bool = false;
                for(var j = 0; j < c.getSize(); j++){
                        //lat = c.getMarkers()[j].getPosition().lat();
                        //console.log(j);
                        data[0].forEach(function(entry) {

                                if (bool){
                                        //debug statements for comparisons
                                        console.log(String(parseFloat(entry.lattitude)));
                                        console.log(String(parseFloat(c.getMarkers()[j].getPosition().lat())));
                                        bool = false;
                                }

                                if (parseFloat(entry.lattitude) == c.getMarkers()[j].getPosition().lat()  && parseFloat(entry.longitude) == c.getMarkers()[j].getPosition().lng()) {
                                        laupdatePoint+=entry.crime+"\n";
                                }
                        });
                }
                alert(lat);*/
                c.clusterIcon_.div_.title =  c.getSize() + ' crimes in this area';// \n Crimes Include: \n'+lat;
            }
        });
}

function changeGradient() {
  var gradient = [
   'rgba(0, 0, 0, 0)',
    'rgba(120, 0, 50, 1)',
    'rgba(140, 0, 50, 1)',
    'rgba(160, 0, 50, 1)',
   'rgba(180, 0, 50, 1)',
    'rgba(200, 0, 50, 1)',
    'rgba(200, 10, 50, 1)',
    'rgba(200,20, 50, 1)',
   'rgba(200, 30, 50, 1)',
    'rgba(200, 50, 10, 1)',
   'rgba(200, 100, 0, 1)',
    'rgba(220, 160, 0, 1)',
   'rgba(240, 160, 0, 1)',
    'rgba(255, 0, 0, 1)'
  ]
  heatmap.set('gradient', heatmap.get('gradient') ? null : gradient);
heatmap.set('opacity', heatmap.get('opacity') ? null : 1);
	heatmap.set('radius', heatmap.get('radius') ? null : 10);
}
function changeRadius() {
  heatmap.set('radius', heatmap.get('radius') ? null : 15);
}
function changeOpacity() {
  heatmap.set('opacity', heatmap.get('opacity') ? null : 1);
}
// Heatmap data
function getPoints() {
	var temp = [];

	%	for item in bottleData[0]:
	%		if item['lattitude'] != None and item['longitude'] != None:
				temp.push (new google.maps.LatLng({{item['lattitude']}}, {{item['longitude']}}) );
	%		end
	%	end

  	return temp;
}

function updatePoints() {
	var tempNew = [];

	//parse our new json from ajax
  	var count = Object.keys(data[0]).length;
  	console.log(count);

	for(var i = 0 ; i < count; i++){

		//each dict will be previously defined
		//put in appropriate crime key of the crime dict
		//put in appropriate district key of district dict
	        //put in appropriate weapon key of weapon dict

		console.log(JSON.stringify(data[0][i]['lattitude'])+", "+JSON.stringify(data[0][i]['longitude']));
		if(JSON.stringify(data[0][i]['longitude']) != null && JSON.stringify(data[0][i]['lattitude']) != null){
			tempNew.push(new google.maps.LatLng(data[0][i]['lattitude'], data[0][i]['longitude']) );
		}
	}
  	return tempNew;
}
</script>

<script type="text/javascript">

function countData(x_data, possible_x, total_for_x, x_array, date, valid_keys_used, keep_track_keys_arr, num_of_incidents_lookup){

    var number_of_incidents_for_key;
    var index_of_key;
    var data_entry_at_index;
    var breakup_of_data;
    var num_of_incidents_in_entry;
    var re_enter_data;
    var new_type_date_key;

    var type_date_key = x_data + ":" + date;

    //if the data we are seeking is not already in the possibility array then push it there
    if(x_data != 'null' && isInArray(x_data, possible_x) == false){
        possible_x.unshift(x_data);
        total_for_x[x_data] = 0;

    }

    if(isInArray(x_data, possible_x)){
        //if first time looking at this data for this crime
        //remember that field array is a associative array and in this instance acts like a dict

        if(isInArray(type_date_key, keep_track_keys_arr) == false){
            keep_track_keys_arr.unshift(type_date_key);
            //we need to be able to refer to how many incidents have occured with this data later on
            num_of_incidents_lookup[type_date_key] = 1;

            //store away the entry for this data and the amount of incidents in the array
            type_date_key = type_date_key + ":1";
            valid_keys_used.unshift(type_date_key);

        }

        else{

            //let's get how many incidents have occurred with this exact data
            number_of_incidents_for_key = num_of_incidents_lookup[type_date_key];
            new_type_date_key = type_date_key + ":" + number_of_incidents_for_key.toString();

            //get the index of the data key we are looking at currently
            index_of_key = valid_keys_used.indexOf(new_type_date_key);

            //get the data from the array of final entries
            data_entry_at_index = valid_keys_used[index_of_key]

            breakup_of_data = data_entry_at_index.split(":");
            num_of_incidents_in_entry = breakup_of_data[2];
            //convert it to an int and add one then convert back
            num_of_incidents_in_entry = parseInt(num_of_incidents_in_entry, 10);
            num_of_incidents_in_entry = num_of_incidents_in_entry + 1;
            breakup_of_data[2] = num_of_incidents_in_entry.toString();

            re_enter_data = breakup_of_data[0] + ":" + breakup_of_data[1] + ":" + breakup_of_data[2];
            valid_keys_used[index_of_key] = re_enter_data;

            num_of_incidents_lookup[type_date_key] = number_of_incidents_for_key + 1;

        }

        /////////////////////////////////
        //javascript is really weird about associative arrays. If at least one of the keys is the same
        //  then it will count it as a valid entry no matter what the other pair of the key is
        //  ex. test["foo", "bar"] is the only entry in the array test
        //          but test["f", "bar"] will give the same value/address
        //THIS WORKS FOR TOTAL
        if(x_array[date, x_data] == undefined){
            //to mark we've seen something like this
            x_array[date, x_data] = 1;
            total_for_x[x_data] = 1;
        }
        else{
            //increment for the overall category
            total_for_x[x_data] += 1;
        }
        ///////////////////////////////////////////
    }

    return;
}

function createPieData(possible_x, total_for_x){

    var x_data_values = [];
    var possibility_value;
    var x_pie_data_set = [];
    var i;

    //create an array where each entry is an instance of a field and the corresponding
    //  value is the amount of occurence
    for(i = 0; i < possible_x.length; i++){
         possibility_value = possible_x[i];
         x_data_values.unshift(total_for_x[possibility_value]);
         x_pie_data_set.unshift([possibility_value, total_for_x[possibility_value]]);

    }

    return x_pie_data_set;
}

function draw_pie_chart(container, data, blurb) {

    $(container).highcharts({
        credits: {
                enabled: false
            },
        navigation: {
            buttonOptions: {
                enabled: false
            }
        },
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: blurb
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}% {point.y:.1f}</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                size: '100%',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.y:.1f}, {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: data


        , showInLegend: true,
            data: data


        }]
    },function(chart) {

        $(chart.series[0].data).each(function(i, e) {
            e.legendItem.on('click', function(event) {
                var legendItem=e.name;

                event.stopPropagation();

                $(chart.series).each(function(j,f){
                       $(this.data).each(function(k,z){
                           if(z.name==legendItem)
                           {
                               if(z.visible)
                               {
                                   z.setVisible(false);
                               }
                               else
                               {
                                   z.setVisible(true);
                               }
                           }
                       });
                });

            });
        });
    }

    );

}

function formatData(unique_incident_arr, possible_x){

    var line_data_array = [];
    var count = possible_x.length;

    var i;
    var j;
    var k;
    var epoch_time;
    var temp_day;
    var previous_epoch;

    //hours*minutes*seconds*milliseconds
    var one_day = 86400000;
    var first_date;
    var diff_days;
    var first_zero_day;
    var second_zero_day;
    var first_run_pass = false;

    //we want an array for each type of the field selected that we have found
    for(i = 0; i < count; i++){
        line_data_array.unshift([]);
    }

    //we need to iterate through each type of field
    for(j = 0; j < count; j++){
        //we need to iterate through each entry in the data
        for(k = 0; k < unique_incident_arr.length; k++){

            broken_up_array = unique_incident_arr[k].split(":");

            //if the type of field is the same (ex. Larceny or Federal hill
            if(broken_up_array[0] == possible_x[j]){

                date = broken_up_array[1];
                number_of_incidents = parseInt(broken_up_array[2], 10);
                epoch_time = new Date(date).getTime();

                //previous_epoch needs something in it first so if we've past the first loop

                if(first_run_pass == true){

                    //how many days has it been between previous_epoch and epoch_time
                    diff_days = Math.round(Math.abs((previous_epoch - epoch_time)/(one_day)));

                    //problems if it's edge case of years??????????????????????
                    if(diff_days > 1){
                        //BECAUSE OF THE WAY THE DATA WAS GIVEN TO ME EVERYTHING IS IN DESCENDING ORDER (double check this)
                        //highcharts plots point by point and not by overall curve fit
                        //previous_epoch is actually greater than epoch_time

                        //get the day before previous epoch and push it on the list
                        first_zero_day = previous_epoch + 86400000;

                        //get the day after this epoch time and push it
                        second_zero_day = epoch_time - 86400000;

                        if(first_zero_day != second_zero_day){

                            line_data_array[j].unshift([first_zero_day, 0]);
                            line_data_array[j].unshift([second_zero_day, 0]);
                        }
                        //when diff days is 2 then there is only one day that can
                        //be zero so let's do so
                        else{
                            line_data_array[j].unshift([second_zero_day, 0]);
                        }


                    }
                }

                //push the array of epoch and num of incidents to the line
                //  data array
                line_data_array[j].unshift([epoch_time, number_of_incidents]);


                previous_epoch = epoch_time;
                first_run_pass = true;

            }

        }
        //zero out
        first_run_pass = false;
        previous_epoch = 0;

    }
    return line_data_array;
}


function countForBarCharts(data_array){
    var month;
    var year;
    var broken_up_entry;
    var broken_up_date;
    var month_year;
    var grouping_and_incidents = [];
    var date_array = [];
    var date;
    var corresponding_num_incidents = [];
    var incidents;
    var index;
    var overall_x_data = [];

    var i;
    //go through each entry we are given
    for(i = 0; i < data_array.length; i++){
        broken_up_entry = data_array[i].split(":");
        date = broken_up_entry[1];
        incidents = broken_up_entry[2];
        incidents = parseInt(incidents, 10);

        epoch_time = new Date(date).getTime();

        if(date_array.indexOf(epoch_time) == -1){
            date_array.push(epoch_time);
            corresponding_num_incidents.push(incidents);
        }
        else{
            index = date_array.indexOf(epoch_time);
            corresponding_num_incidents[index] += incidents;
        }
    }

    var i;
    var epoch_entry;
    var incident_entry;
    var bar_data_arr = [];
    for(i = 0; i < date_array.length; i++){
        epoch_entry = date_array[i];
        incident_entry = corresponding_num_incidents[i];

        bar_data_arr.push([epoch_entry, incident_entry]);
    }

    overall_x_data.push(bar_data_arr);
    return overall_x_data;
}


function formatDataForBarChart(date_array, corresponding_value_arr){

    var count = date_array.length;
    var i;
    var overall_data_array = [];
    var epoch_time;
    var all_date_array = [];
    var date_entry;
    var correspond_entry;

    for(i = 0; i < count; i++){
        date_entry = date_array[i];
        epoch_time = new Date(date_entry).getTime();
        correspond_entry = corresponding_value_arr[i];
        overall_data_array.push([epoch_time, correspond_entry]);

    }

    return overall_data_array;
}


google.charts.load('current', {'packages':['corechart']});

function drawChart() {

    var count = Object.keys(data[0]).length;

    var crime_array = [];
    var neighborhood_array = [];
    var weapon_array = [];
    var district_array = [];

    var possible_crimes = [];
    var possible_neighborhoods = [];
    var possible_weapons = [];
    var possible_districts = [];

    var total_for_crimes = [];
    var total_for_neighborhoods = [];
    var total_for_weapons = [];
    var total_for_districts = [];

    var crime_data;
    var neighborhood_data;
    var weapon;
    var district_data;

    var date;
    var crime_valid_keys_used = [];
    var neighborhood_valid_keys_used = [];
    var weapon_valid_keys_used = [];
    var district_valid_keys_used = [];

    var crime_keep_track_keys_arr = [];
    var neighborhood_keep_track_keys_arr = [];
    var weapon_keep_track_keys_arr = [];
    var district_keep_track_keys_arr = [];

    var crime_num_of_incidents_lookup = [];
    var neighborhood_num_of_incidents_lookup = [];
    var weapon_num_of_incidents_lookup = [];
    var district_num_of_incidents_lookup = [];


    var crime_line_data_arr = [];
    var neighborhood_line_data_arr = [];
    var weapon_line_data_arr = [];
    var district_line_data_arr = [];

    var overall_crime_arr = [];
    var overall_neighborhood_arr = [];
    var overall_weapon_arr = [];
    var overall_district_arr = [];

    var overall_crime_corresponding_arr = [];
    var overall_neighborhood_corresponding_arr = [];
    var overall_weapon_corresponding_arr = [];
    var overall_district_corresponding_arr = [];

    //the goal is to count how many crimes occured for each crime type on each day
    for(var i = 0; i < count; i++){

        date = data[0][i]['date'].substr(0,10);

        crime_data = data[0][i]['crime'];
        neighborhood_data = data[0][i]['neighborhood'];
        weapon_data = data[0][i]['weapon'];
        district_data = data[0][i]['district'];



        countData(crime_data, possible_crimes, total_for_crimes, crime_array, date, crime_valid_keys_used, crime_keep_track_keys_arr, crime_num_of_incidents_lookup);

        countData(neighborhood_data, possible_neighborhoods, total_for_neighborhoods, neighborhood_array, date, neighborhood_valid_keys_used, neighborhood_keep_track_keys_arr, neighborhood_num_of_incidents_lookup);
        countData(weapon_data, possible_weapons, total_for_weapons, weapon_array, date, weapon_valid_keys_used, weapon_keep_track_keys_arr, weapon_num_of_incidents_lookup);
        countData(district_data, possible_districts, total_for_districts, district_array, date, district_valid_keys_used, district_keep_track_keys_arr, district_num_of_incidents_lookup);
    }

    crime_line_data_arr = formatData(crime_valid_keys_used, possible_crimes);
    neighborhood_line_data_arr = formatData(neighborhood_valid_keys_used, possible_neighborhoods);
    weapon_line_data_arr = formatData(weapon_valid_keys_used, possible_weapons);
    var o;
    var p;


    district_line_data_arr = formatData(district_valid_keys_used, possible_districts);

    var crime_bar_data;
    var neighborhood_bar_data;
    var weapon_bar_data;
    var district_bar_data;
    var tempor;

    overall_arr = countForBarCharts(crime_valid_keys_used);
//    overall_neighborhood_arr =  countForBarCharts(neighborhood_valid_keys_used);
//    overall_weapon_arr = countForBarCharts(weapon_valid_keys_used);
//    overall_district_arr = countForBarCharts(district_valid_keys_used);


    var r;
    for(r = 0; r < crime_line_data_arr.length; r++){
        crime_line_data_arr[r].reverse();
    }
    for(r = 0; r < neighborhood_line_data_arr.length; r++){
        neighborhood_line_data_arr[r].reverse();
    }
    for(r = 0; r < weapon_line_data_arr.length; r++){
        weapon_line_data_arr[r].reverse();
    }
    for(r = 0; r < district_line_data_arr.length; r++){
        district_line_data_arr[r].reverse();
    }


    var neighborhood_pie_data_set;
    var crime_pie_data_set;
    var weapon_pie_dat_set;
    var district_pie_data_set;

    crime_pie_data_set = createPieData(possible_crimes, total_for_crimes);
    neighborhood_pie_data_set = createPieData(possible_neighborhoods, total_for_neighborhoods);
    weapon_pie_data_set = createPieData(possible_weapons, total_for_weapons);
    district_pie_data_set = createPieData(possible_districts, total_for_districts);

    var display_list = ["incidents"];

    draw_pie_chart("#crime_pie_chart", crime_pie_data_set, "Crime distribution");
    draw_pie_chart("#neighborhood_pie_chart", neighborhood_pie_data_set, "Neighborhood distribution");
    draw_pie_chart("#weapon_pie_chart", weapon_pie_data_set, "Weapon distribution");
    draw_pie_chart("#district_pie_chart", district_pie_data_set, "District distribution");

    drawLineChart(overall_arr, display_list, "#overall_line_chart", "Overall Line Graph");
    drawLineChart(crime_line_data_arr, possible_crimes, "#crime_line_chart", "Crime Graph");
    drawLineChart(neighborhood_line_data_arr, possible_neighborhoods, "#neighborhood_line_chart", "Neighborhood Graph");
    drawLineChart(weapon_line_data_arr, possible_weapons, "#weapon_line_chart", "Weapon Graph");
    drawLineChart(district_line_data_arr, possible_districts, "#district_line_chart", "District Graph");

    drawBarChart(crime_line_data_arr, possible_crimes, "#crime_bar_chart", "Crime Bar Chart");
    drawBarChart(neighborhood_line_data_arr, possible_neighborhoods, "#neighborhood_bar_chart", "Neighborhood Bar Chart");
    drawBarChart(weapon_line_data_arr, possible_weapons, "#weapon_bar_chart", "Weapon Bar Chart");
    drawBarChart(district_line_data_arr, possible_districts, "#district_bar_chart", "District Bar Chart");


    drawBarChart(overall_arr, display_list, "#overall_bar_chart", "Overall Bar Chart");

}

function drawLineChart(data, name_list, container, graph_text){

      var testing;
      var array = [];

      var num_of_elements;
      var bit = 0;
      for(var i = 0; i < name_list.length; i++){
      testing = {
                name : name_list[i],
                data : data[i],
                type: 'spline',
                tooltip: {
                    valueDecimals: 2
                }
            }
      array.push(testing);
      }

        // Create the chart
        $(container).highcharts('StockChart', {

            credits: {
                enabled: false
            },
            navigation: {
                buttonOptions: {
                    enabled: false
                }
            },
            scrollbar: {
            enabled: false
            },
            navigator: {
            enabled: false
            },
            legend: {
                enabled: true,
                align: 'right',
                backgroundColor: '#FFFFFF',
                borderColor: 'black',
                borderWidth: 2,
                layout: 'vertical',
                verticalAlign: 'top',
                y: 100,
                shadow: true
            },
            rangeSelector : {
                inputEnabled: false,
                allButtonsEnabled: true,
                buttons: [{
                    type: 'all',
                    text: 'Day',
                    dataGrouping: {
                        approximation: "sum",
                        forced: true,
                        units: [['day', [1]]]
                    }
                }, {
                    type: 'all',
                    text: 'Week',
                    dataGrouping: {
                        approximation: "sum",
                        forced: true,
                        units: [['week', [1]]]
                    }
                }, {
                    type: 'all',
                    text: 'Month',
                    dataGrouping: {
                        approximation: "sum",
                        forced: true,
                        units: [['month', [1]]]
                    }
                },{
                    type: 'all',
                    text: '1yr',
                    dataGrouping: {
                        approximation: "sum",
                        forced: true,
                        units: [['year', [1]]]
                    }
                }
                ],
                buttonTheme: {
                    width: 60
                },
                selected: 2
            },

            buttonOptions: {
                enabled: false
            },
            title : {
                text : graph_text
            },

            series : array,
        });



  }

//bar
function drawBarChart(data, name_list, container, graph_text) {

//    $.getJSON('https://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?', function (data) {

	var testing;
      var array = [];

      var num_of_elements;

      for(var i = 0; i < name_list.length; i++){
      testing = {
                name : name_list[i],
                data : data[i],
                type: 'column',
                tooltip: {
                    valueDecimals: 2
                }
            }
      array.push(testing);
      }

        // Create the chart
        $(container).highcharts('StockChart', {

						            yAxis: {
                opposite:false
            },

						credits: {
                enabled: false
            },
            scrollbar: {
            enabled: false
            },
            navigator: {
                enabled: true,
                height: 0,
                width: 0,
                outlineColor: 'white',
                visible: false
            },
            legend: {
                enabled: true,
                align: 'right',
                backgroundColor: '#FFFFFF',
                borderColor: 'black',
                borderWidth: 2,
                layout: 'vertical',
                verticalAlign: 'top',
                y: 100,
                shadow: true
            },
            rangeSelector : {
                inputEnabled: false,
                allButtonsEnabled: true,
                buttons: [{
                    type: 'all',
                    count: 1,
                    text: 'Day',
                    dataGrouping: {
                        forced: true,
                        units: [['day', [1]]]
                    }
                }, {
                    type: 'all',
                    count: 1,
                    text: 'Week',
                    dataGrouping: {
                        forced: true,
                        units: [['week', [1]]]
                    }
                }, {
                    type: 'all',
                    text: 'Month',
                    dataGrouping: {
                        forced: true,
                        units: [['month', [1]]]
                    }
                },{
                    type: 'all',
                    text: 'yr',
                    dataGrouping: {
                        forced: true,
                        units: [['year', [1]]]
                    }
                }],
                buttonTheme: {
                    width: 60
                },
                selected: 2
            },

            title : {
                text : graph_text
            },

            _navigator: {
                enabled: false
            },

            series: array
        }
        );
}

    </script>

	<script>
	//ajax calls to handle realtime updates of query data

	$('#crimeFilters').submit(function(e) {
		//alert("Submitted crime filters jquery");
        if(!ajaxInProgress){
        console.log('calling ajax');
        ajaxInProgress = true;
        //$("#status").show();
        $body = $("body");

            $body.addClass("loading");

        $.ajax({
            type: 'POST',
            url: '/ajax',
			contentType: "application/json",
            data: $(this).serialize(),
            success: function(json) {
                    //$("#status").hide();
                    ajaxInProgress = false;
                    $body.removeClass("loading");
		    updateViewData(json);
            }
        });
        } //end boolean check
        e.preventDefault();

    });


	</script>


  <!--histogram time slider-->
	<script>

var histogramData = [];

%	for item in bottleData[2]:
		histogramData.unshift([Date.parse("{{item[0]}}"), {{item[1]}}]);
%	end


  var rangeSelectorHeight = 20;
  var navigatorHeight = 65;
  var chart;

    $('#dateSlider').highcharts('StockChart', {

        rangeSelector : {
				selected : 1,
        height: rangeSelectorHeight
			},
      navigator :
      {
      enabled: true,
      height: navigatorHeight
      },
      chart: {
        backgroundColor: {
              linearGradient: { x1: 0, y1: 0, x2: 1, y2: 1 },
              stops: [
                  [0, 'rgb(255, 255, 255)'],
                  [1, 'rgb(200, 200, 255)']
              ]
          },
          height: rangeSelectorHeight + navigatorHeight + 50
      },
	tooltip: {
            enabled: false
        },
	plotOptions: {
            series: {
                states: {
                    hover: {
                        enabled: false
                    }
                }
            }
        },
      scrollbar:
      {
        enabled: true
      },
      legend: {
            enabled: false
        },
        xAxis:{
              labels: {
                enabled: false
            },
            	visible: false,
                events:{
                    afterSetExtremes:function(){

            var minDate = Highcharts.dateFormat('%m-%d-%Y', this.min);
            var maxDate = Highcharts.dateFormat('%m-%d-%Y', this.max);

           $('#min').val(Date.parse(minDate));
	          $('#max').val(Date.parse(maxDate));
	           $("#crimeFilters").submit();

                    }
                }
            },
        yAxis: {
            visible: false
        },

	credits: false,

        series: [{data: histogramData}]
    });

  chart = $('#dateSlider').highcharts();


// clicking the New link in the Custom Date Range button calls this function
  $('.dateRangeLink').click(function() {

    var defaultRangeName = Highcharts.dateFormat('%m-%d-%Y', chart.xAxis[0].getExtremes().min) + " to " + Highcharts.dateFormat('%m-%d-%Y', chart.xAxis[0].getExtremes().max);

bootbox.prompt({
  title: "Please enter in a name for the new date range:",
  value: defaultRangeName,
  callback: function(rangeName) {
    if (rangeName === null) {
      this.show("Prompt dismissed");
    } else if (jQuery.trim(rangeName).length == 0) {
	bootbox.alert("Not a valid name, please try again.");
	}
	else {
      	var big = document.getElementById("links");
	var li = document.createElement('li');
	li.className = 'dynamic-link';
	li.innerHTML = '<a class="hello" href="#">' + rangeName + '</a>';
	li.min = chart.xAxis[0].getExtremes().min;
	li.max = chart.xAxis[0].getExtremes().max;
	big.appendChild(li);
	li.onclick = dynamicSetRange;
    }
  }
});
  });
  function dynamicSetRange() {
    chart.xAxis[0].setExtremes(this.min, this.max);
  }
</script>

<script>
// clicking the New link in the Custom Query button calls this function
$('.customQueryLink').click(function() {

bootbox.prompt({
  title: "Please enter in a name for the new query:",
  value: "Query " + customQueryNumber,
  callback: function(queryName) {
    if (queryName === null) {
      this.show("Prompt dismissed");
	}
	else if (jQuery.trim(queryName).length == 0)
	{
	bootbox.alert("Not a valid name, please try again.");
	}
     else {
      		var list = [];
	    	var big = document.getElementById("customQueryLinks");
		var li = document.createElement('li');
		li.className = 'dynamic-link';


		var inputs = document.getElementsByTagName('input');
		for(var i=0; i<inputs.length; i++){
		if(inputs[i].getAttribute('type')=='checkbox'){
			list.push(inputs[i].checked);
		}
		}
		li.checkboxes = list;

		li.innerHTML = '<a class="hello" href="#">' + queryName + '</a>';
		li.min = chart.xAxis[0].getExtremes().min;
		li.max = chart.xAxis[0].getExtremes().max;

		big.appendChild(li);
		li.onclick = dynamicSetQuery;
		if(queryName == "Query".concat(" ",customQueryNumber))
		{
			customQueryNumber += 1;
		}
    }
  }
});

  });

function dynamicSetQuery() {

	var inputs = document.getElementsByTagName('input');
		for(var i=0; i<inputs.length; i++){
		if(inputs[i].getAttribute('type')=='checkbox'){
			inputs[i].checked = this.checkboxes[i];
		}
		}

    chart.xAxis[0].setExtremes(this.min, this.max);
	$("#crimeFilters").submit();

  }
</script>

<script>
function renderMap(){

	if (data != null) {
		updateMap();
	}
	else {
		initMap();
	}
}
</script>

</body>
</html>

function log(t){console.log(t);}

function setTop(data)
{
  if(typeof data == "undefined") return;
	var ts = data.split("\n")
  if(typeof ts[2] == "undefined") return;
	var css = ts[2].toString().replace(/\s\s+/g,' ').replace(/\s/g,'|').split("|");
	var c  = css[1].split(" ")[0];
    $( "#cpu" ).html( css[0]+" "+c );
	var ms = ts[3].toString().replace(/\s\s+/g,'|').split("|");
//	log(css);
	var used = Math.round(parseInt(ms[2].split(" ")[0])/1024);
	var free = Math.round(parseInt(ms[3].split(" ")[0])/1024);
  	$( "#mem" ).html( "Mb mem: "+used+" / "+free );
}
function setDisk(data)
{
	var ss = data.split("\n")[1].toString().replace(/\s\s+/g,'|');
	var m = ss.split("|");
//	log(ss);
	$( "#disk" ).html( "Disk free: "+m[2]+" / "+m[3] );
}
function setNet(data) {
	$("#traf").text(data);
}
function setEthBalance(data) {
	var eth = data/Math.pow(10,18)
	$("#ethbalance").text(eth);
}
function setFarmList(data) {
	$("#farm_list").html(data);
  setupRigs();
}

function setupRigs()
{
  $("tr.rig-control").click(function() {
    clearInterval(timer);
    var content = $("main");
    var lnk = $(this);
    content.html('');
    $.get( lnk.attr("link"), function(data){
      content.html(data);
      setupRig(lnk.attr("mac"));
    });
    return false;
  });
}
function setRigState(newstate)
{
 $(".state").attr("state "+newstate); 
}
function setRigStats(stats)
{
 $("#farm_stats").html(stats); 
}
function updMinerLog(log)
{
 $("#miner_log").html(log); 
}
function updQuestLog(log)
{
 $("#quest_log").html(log); 
}
function updtop(log)
{
 $("#top").html(log); 
}

function setupRig(mac)
{
  timer = setInterval(function(){
		$.get("/cgi-bin/farm-state.sh?"+mac, setRigState);
		$.get("/cgi-bin/farm-stats.sh?"+mac, setRigStats);
    $.get("/cgi-bin/farm-log.sh?"+mac, updMinerLog);
    $.get("/cgi-bin/farm-top.sh?"+mac, updtop);
		$.get("/cgi-bin/quest-log.sh?"+mac, updQuestLog);
  },3600);
  $('#rigTab').tab();  
  $('#rigTab a:first').tab('show');  
  var info = $('.top-panel').detach();
  $('nav.navbar').append(info);  
  $("#frm_overclock").submit(function(){
    $("#frm_overclock").ajaxSubmit({
      method: "GET",
      target: "#result_overclock",
    // timeout: 3000,
      beforeSubmit: function(arr, $form, options) {
        $("#frm_submit").attr("disabled","disabled");
        $("#frm_submit").val("Applying changes...");
        $("#result_overclock").html("Wait, please...");
      },
      success: function() {
        $("#frm_submit").removeAttr("disabled");
        $("#frm_submit").val("Apply");
      }
    });
    return false;
  });
  $("#frm_overclock input[type='range']").on("input",function(){
    $(this).siblings( ".ovalue" ).text($(this).val());
  });
}

function btn_farm_control(event)
{
	var target = $( event.target );
	var txt = target.text();
	var name = target.siblings(".modal-title").text();
	if(!confirm(txt+" "+name+"?")) return false;
	var lnk = target.attr("data-target");
	$.get(lnk);
}
var timer;
$(document).ready(function(){
//	setEthBalance(548930101534261);

	$.get("/cgi-bin/farm-list.sh", setFarmList);
	timer = setInterval(function(){
		$.get("/cgi-bin/top.sh", setTop);
		$.get("/cgi-bin/df.sh", setDisk);
		$.get("/cgi-bin/traf.sh", setNet);
		$.get("/cgi-bin/farm-list.sh", setFarmList);
	}, 4500);

//	var ifr_log = document.getElementById('farm_log');
//
//	$("#farm_control").on("show.bs.modal", function(e) {
//    var link = $(e.relatedTarget);
//    var content = $(this).find(".modal-content")
//    content.html('');
//    content.load(link.attr("href"));
//	});
//
	// ifr_log.onload = function () {
	//     ifr_log.contentWindow.scrollTo(0,999);
	// }
	// window.setInterval(function(){ifr_log.contentWindow.location.reload();}, 3000);

});

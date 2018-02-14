<div class="container">
  <h1 class="rig-title"> <span class="state {state}"></span> {name}</h1>
  <span id="farm_stats">{farmstats}</span>
  <button type="button" data-target="/cgi-bin/givequest/hardbutton.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Hard Reset</button>

  <!--button type="button" data-target="/cgi-bin/givequest/wakeonlan.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Wake on lan</button-->
  
  <button type="button" data-target="/cgi-bin/givequest/reboot.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Reboot</button>
  
  <button type="button" data-target="/cgi-bin/givequest/shutdown.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Shutdown</button>
  <button type="button" data-target="/cgi-bin/givequest/restartminer.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Restart Miner</button>
  <button type="button" data-target="/cgi-bin/givequest/switch2zec.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Go to ZEC</button>
  <button type="button" data-target="/cgi-bin/givequest/switch2ethdcr.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Go to ETH-DCR</button>
  <!--button type="button" data-target="/cgi-bin/givequest/switch2vtc.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Switch to VTC</button-->
  <button type="button" data-target="/cgi-bin/set-rig-descr.sh?{ID}" class="btn" onClick="btn_set_descr(event);">Rig Description</button>
  <div class="top-panel">  
    <span>{name} - {descr}</span>
  </div> 
  <div style="clear:both;"></div>
  <ul class="nav nav-tabs" role="tablist" id="rigTab">
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#miner">Miner Log</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#quest_log">Quest Log</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#overclock">Overclock</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#hardware">Hardware</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#top">TOP</a></li>
  </ul>
  <div class="tab-content">
    <div id="miner" role="tabpanel" class="tab-pane fade">
      <div id="miner_log">
        {minerlog}
      </div>
    </div>
    <div id="quest_log" role="tabpanel" class="tab-pane fade">
      {questlog}
    </div>
    <div id="overclock" role="tabpanel" class="tab-pane fade">
      {overclockform}
    </div>
    <div id="hardware" role="tabpanel" class="tab-pane fade">
      <p>GPIO pin: <b>{gpio}</b></p>
      <img src="/i/gpio-numbers-pi2.png" width="90%">
      <iframe id="farm_lshw" marginwidth="0" marginheight="0" width="100%" height="600" frameborder=1 src="cgi-bin/farm-lshw.sh?{ID}"></iframe>
    </div>
    <div id="top" role="tabpanel" class="tab-pane fade">
      {toplog}
    </div>
  </div>
  <hr>
  <span>[{descr}] IP: {IP} MAC: {ID}</span>
</div>

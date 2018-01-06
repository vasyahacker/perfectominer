<div class="container">
  <h1> <div class="state {state}"></div> {name}</h1>
  <button type="button" data-target="/cgi-bin/givequest/hardbutton.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Hard reset / power</button>

  <button type="button" data-target="/cgi-bin/givequest/wakeonlan.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Wake on lan</button>
  
  <button type="button" data-target="/cgi-bin/givequest/reboot.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Reboot</button>
  
  <button type="button" data-target="/cgi-bin/givequest/shutdown.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Shutdown</button>
  <button type="button" data-target="/cgi-bin/givequest/restartminer.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Restart miner</button>
  <button type="button" data-target="/cgi-bin/givequest/switch2zec.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Switch to ZEC</button>
  <button type="button" data-target="/cgi-bin/givequest/switch2ethdcr.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Switch to ETH-DCR</button>
  <button type="button" data-target="/cgi-bin/givequest/switch2vtc.sh?{ID}" class="btn" onClick="btn_farm_control(event);">Switch to VTC</button>
  <div class="top-panel">  
    <span>{name}</span>
  </div> 

  <span>IP: {IP} MAC: {ID}</span>
  <span id="farm_stats">{farmstats}</span>
  <ul class="nav nav-tabs" role="tablist" id="rigTab">
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#miner">Miner log</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#quest_log">Quest log</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#overclock">Overclock</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#hardware">Hardware</a></li>
    <li class="nav-item"><a class="nav-link" data-toggle="tab" role="tab" href="#top">top</a></li>
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
      <iframe id="farm_lshw" marginwidth="0" marginheight="0" width="100%" height="207" frameborder=1 src="cgi-bin/farm-lshw.sh?{ID}"></iframe>
      <p>GPIO pin: <b>{gpio}</b></p>
      <img src="/i/gpio-numbers-pi2.png" width="90%">
    </div>
  	<div id="top" role="tabpanel" class="tab-pane fade">
      {toplog}
    </div>
  </div>
</div>

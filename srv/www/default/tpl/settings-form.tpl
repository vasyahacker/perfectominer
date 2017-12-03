<form id="frm_settings" action="/cgi-bin/settings.sh" method="get">
  <fieldset>
    <legend>Wifi</legend>
     <p>
      <label for="wifi-ssid">SSID: </label>
      <select name="wifi-ssid">
        {wifi-ssid-list}
      </select>
    </p>
    <p>
      <label for="wifi-pass">Pass: </label>
      <input type="password" name="wifi-pass" value="{wifo-pass}">
    </p>
   </fieldset>
  <fieldset>
    <legend>Wallets</legend>
    <p>
      <label for="eth-wallet">ETH Wallet: </label>
      <input type="text" name="eth-wallet" value="{eth-wallet}">
    </p>
    <p>
      <label for="zec-wallet">ZEC Wallet: </label>
      <input type="text" name="zec-wallet" value="{zec-wallet}">
    </p>
   </fieldset>
     <fieldset>
      <legend>Pools</legend>
      <p>
        <label for="decred-pool">Decred pool address: </label>
        <input type="text" name="decred-pool" value="{decred-pool}">
      </p>
   </fieldset>
  <fieldset>
    <legend>Overclock default values</legend>
    <p>
      <label for="nv-fan-speed">Fan speed: </label>
      <input type='range' step="10" min="0" max="100" name='nv-fan-speed' value='{fan}'>
      <span class="ovalue">{fan}</span> (0 = auto)
    </p>
    <p>
      <label for='nv-gpu-overclock'>GPU clock: </label>
      <input min="0" max="200" type='range' name='nv-gpu-overclock' value='{gpu}'>
      <span class="ovalue">{gpu}</span>
    </p>
    <p>
      <label for='nv-mem-overclock'>Mem clock: </label>
      <input min="0" max="2000" type='range' name='nv-mem-overclock' value='{mem}'>
      <span class="ovalue">{mem}</span>
    </p>
 </fieldset>

  <p><input id="frm_submit" type="submit" value="Apply"><span id="settings_result"></span></p>
</form>

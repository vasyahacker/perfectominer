  
  <fieldset>
    <legend>[{id}] {card_name}</legend>
    <p>
      <label for="nv-fan{id}-speed">Fan speed: </label>
      <input class="range-line" type='range' step="10" min="0" max="100" name='nv-fan{id}-speed' value='{fan}'>
      <span class="ovalue">{fan}</span> (0 = auto)
    </p>
    <p>
      <label for='nv-gpu{id}-overclock'>GPU clock: </label>
      <input class="range-line" min="0" max="200" type='range' name='nv-gpu{id}-overclock' value='{gpu}'>
      <span class="ovalue">{gpu}</span>
    </p>
    <p>
      <label for='nv-mem{id}-overclock'>Mem clock: </label>
      <input class="range-line" min="0" max="2000" type='range' name='nv-mem{id}-overclock' value='{mem}'>
      <span class="ovalue">{mem}</span>
    </p>
 </fieldset>


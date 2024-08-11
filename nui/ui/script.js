const main = document.getElementById('main-cont');
// Asegúrate de que sólo haya un elemento con cada clase o selecciona el índice correcto
const userNameElement = document.getElementsByClassName('user-name')[0];
const userRoleElement = document.getElementsByClassName('user-role')[0];
const userJobElement = document.getElementsByClassName('user-job')[0];
const userCashElement = document.getElementsByClassName('user-cash-q')[0];
const userMoneyElement = document.getElementsByClassName('user-money-q')[0];
const userIdElement = document.getElementsByClassName('user-id')[0];
const serverActivePlayers = document.getElementsByClassName('server-players')[0];
const polDispo = document.getElementsByClassName('pol-avaiable')[0]
const emsDispo = document.getElementsByClassName('ems-avaiable')[0]

//botones
const mapButton = document.getElementsByClassName('map-button')[0]
const settingsButton = document.getElementsByClassName('settings-button')[0]
const audio = document.getElementsByClassName('audioClick1')[0]
const salirButton = document.getElementsByClassName('rectangle-20')[0]
const close = document.getElementsByClassName('rectangle-close')[0]
const audioAbrir = document.getElementsByClassName('audioAbrir')[0]
close.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/closeGui`, {
        dato: 'mostrar mapa'
    })
    audio.play()
})
salirButton.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/disconnect`, {
        dato: 'mostrar mapa'
    })
    audio.play()
})
mapButton.addEventListener('click', () => {
    audio.play()
    axios.post(`https://${GetParentResourceName()}/showMap`, {
        dato: 'mostrar mapa'
    })
    audio.play()
})
settingsButton.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/showSettings`, {
        dato: 'mostrar mapa'
    })
    audio.play()
})



window.addEventListener('message', (event) => {
  console.log(JSON.stringify(event.data));

  if (event.data.action === 'uiEnabled') {
    audioAbrir.play()
    main.classList.add('mostrar');
  } else if (event.data.action === 'uiDisabled') {
    main.classList.remove('mostrar');
  }
});

window.addEventListener('message', (event) => {
  const datos = event.data;

  if (datos.type === 'serverInfo') {
    // Actualizar el contenido de los elementos
    userNameElement.textContent = datos.playerDatas.name
    userRoleElement.textContent = datos.playerDatas.from
    userJobElement.textContent = datos.playerDatas.job +' - '+ datos.playerDatas.jobGrade
    userCashElement.textContent = datos.playerDatas.cash;
    userMoneyElement.textContent = datos.playerDatas.money;
    userIdElement.textContent = datos.playerDatas.id;
    serverActivePlayers.textContent = datos.activePlayersNumber + '/120'
  }
  if(datos.type === 'jobCount'){
    polDispo.textContent = datos.policeCount;
    emsDispo.textContent = datos.emsCount;
  }
});
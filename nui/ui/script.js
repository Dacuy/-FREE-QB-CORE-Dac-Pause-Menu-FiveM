const main = document.getElementById('main-cont');

const userNameElement = document.getElementsByClassName('user-name')[0];
const userRoleElement = document.getElementsByClassName('user-role')[0];
const userJobElement = document.getElementsByClassName('user-job')[0];
const userCashElement = document.getElementsByClassName('user-cash-q')[0];
const userMoneyElement = document.getElementsByClassName('user-money-q')[0];
const userIdElement = document.getElementsByClassName('user-id')[0];
const serverActivePlayers = document.getElementsByClassName('server-players')[0];
const polDispo = document.getElementsByClassName('pol-avaiable')[0];
const emsDispo = document.getElementsByClassName('ems-avaiable')[0];

// Botones
const mapButton = document.getElementsByClassName('map-button')[0];
const settingsButton = document.getElementsByClassName('settings-button')[0];
const audio = document.getElementsByClassName('audioClick1')[0];
const salirButton = document.getElementsByClassName('rectangle-20')[0];
const close = document.getElementsByClassName('rectangle-close')[0];
const audioAbrir = document.getElementsByClassName('audioAbrir')[0];

close.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/closeGui`, { dato: 'mostrar mapa' });
    audio.play();
});

salirButton.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/disconnect`, { dato: 'mostrar mapa' });
    audio.play();
});

mapButton.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/showMap`, { dato: 'mostrar mapa' });
    audio.play();
});

settingsButton.addEventListener('click', () => {
    axios.post(`https://${GetParentResourceName()}/showSettings`, { dato: 'mostrar mapa' });
    audio.play();
});

window.addEventListener('message', (event) => {
    const datos = event.data;

    if (datos.action === 'uiEnabled') {
        const Nombre = datos.servername;
        const Nombres = Nombre.split(' ');
        const Logo = datos.logo;
        const Idioma = datos.language;

        const Logo1 = document.getElementById('logo1');
        const Logo2 = document.getElementById('logo2');
        const NombreServer1 = document.getElementById('Name1');
        const NombreServer2 = document.getElementById('Name2');

        const police = document.getElementById('police');
        const policeDispo = document.getElementById('police_dispo');
        const policeDispo2 = document.getElementById('police_dispo2');
        const mapa = document.getElementById('map');
        const mapa2 = document.getElementById('map2');
        const ajustes = document.getElementById('sets');
        const ajustes2 = document.getElementById('sets2');
        const Work = document.getElementById('work');
        const ManoCash = document.getElementById('cash');
        const BankCash = document.getElementById('bank');
        const MyId = document.getElementById('miId');
        const Salir = document.getElementById('exit');

        // Actualizar el contenido de los elementos basados en el idioma
        if (Idioma === 'en') {
            police.textContent = 'POLICE';
            policeDispo.textContent = 'AVAIABLE';
            policeDispo2.textContent = 'AVAIABLE';
            mapa.textContent = 'MAP';
            mapa2.textContent = 'GAME MAP';
            ajustes.textContent = 'SETTINGS';
            ajustes2.textContent = 'GAME SETTINGS';
            Work.textContent = 'My work:';
            ManoCash.textContent = 'Cash:';
            BankCash.textContent = 'Bank Cash:';
            MyId.textContent = 'My id:';
            Salir.textContent = 'EXIT';
        } else if (Idioma === 'pt') {
            police.textContent = 'POLÍCIA';
            policeDispo.textContent = 'DISPONÍVEL';
            policeDispo2.textContent = 'DISPONÍVEL';
            mapa.textContent = 'MAPA';
            mapa2.textContent = 'MAPA DO JOGO';
            ajustes.textContent = 'CONFIGURAÇÕES';
            ajustes2.textContent = 'CONFIGURAÇÕES DO JOGO';
            Work.textContent = 'Meu trabalho:';
            ManoCash.textContent = 'Dinheiro:';
            BankCash.textContent = 'Dinheiro no banco:';
            MyId.textContent = 'Meu Id:';
            Salir.textContent = 'SAIR';
        }else if (Idioma === 'fr') {
            police.textContent = 'POLICE';
            policeDispo.textContent = 'DISPONIBLE';
            policeDispo2.textContent = 'DISPONIBLE';
            mapa.textContent = 'MAP';
            mapa2.textContent = 'CARTE DU JEU';
            ajustes.textContent = 'CONFIGURATIONS';
            ajustes2.textContent = 'PARAMÈTRES DU JEU';
            Work.textContent = 'Mon travail:';
            ManoCash.textContent = 'Mon argent:';
            BankCash.textContent = 'Mon argent à la banque';
            MyId.textContent = 'Mon ID:';
            Salir.textContent = 'SORTIE';
        }else if (Idioma === 'ru') {
            police.textContent = 'ПОЛИЦИЯ';
            policeDispo.textContent = 'ДОСТУПНО';
            policeDispo2.textContent = 'ДОСТУПНО';
            mapa.textContent = 'КАРТА';
            mapa2.textContent = 'КАРТА ИГРЫ';
            ajustes.textContent = 'КОНФИГУРАЦИИ';
            ajustes2.textContent = 'НАСТРОЙКИ ИГРЫ';
            Work.textContent = 'Моя работа:';
            ManoCash.textContent = 'Мои деньги:';
            BankCash.textContent = 'Мои деньги в банке:';
            MyId.textContent = 'Мой ID';
            Salir.textContent = 'ВЫХОД';
        }
        // Manejo de los nombres
        const nombreP1 = Nombres[0] || '';
        const nombreP2 = Nombres[1] || '';
        const nombreP3 = Nombres[2] || '';
        const nombreP4 = Nombres[3] || '';

        NombreServer1.textContent = nombreP1;

        // Construir el contenido para NombreServer2
        let concatenatedNombre = nombreP2;
        if (nombreP3) {
            concatenatedNombre += ' ' + nombreP3;
        }
        if (nombreP4) {
            concatenatedNombre += ' ' + nombreP4;
        }

        NombreServer2.textContent = concatenatedNombre;

        // Actualizar los estilos de los logotipos
        Logo1.style.setProperty('background', `url(${Logo})`);
        Logo1.style.setProperty('background-size', `cover`);

        Logo2.style.setProperty('background', `url(${Logo})`);
        Logo2.style.setProperty('background-size', `cover`);


        audioAbrir.play();
        main.classList.add('mostrar');
    } else if (datos.action === 'uiDisabled') {
        main.classList.remove('mostrar');
    }

    if (datos.type === 'serverInfo') {
        userNameElement.textContent = datos.playerDatas.name;
        userRoleElement.textContent = datos.playerDatas.from;
        userJobElement.textContent = datos.playerDatas.job + ' - ' + datos.playerDatas.jobGrade;
        userCashElement.textContent = '$ ' + datos.playerDatas.cash;
        userMoneyElement.textContent = '$ ' + datos.playerDatas.money;
        userIdElement.textContent = datos.playerDatas.id;
        serverActivePlayers.textContent = datos.activePlayersNumber + '/120';
    }

    if (datos.type === 'jobCount') {
        polDispo.textContent = datos.policeCount;
        emsDispo.textContent = datos.emsCount;
    }
});

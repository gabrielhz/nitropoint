$(document).ready(function(){

    
	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
            case "updateData":
                atualizarHud(item.values);
            break;
            case "showSpeedometer":
                $('.speedmoter').fadeIn(500);
                atualizarCarHud(item.values);     
            break;
            case "hideSpeedometer":
                $('.speedmoter').fadeOut(500);
            break;
            case "showHud":
                $('#teste').fadeIn(500);  
                $('.speedmoter').fadeOut(500);
            break;
            case "hideHud":
                $('#teste').fadeOut(500);
                $('.speedmoter').fadeOut(500);  
            break;
		}
    });

});

const atualizarCarHud = (data) => {
    //------------- Gasolina -------------//
    var fuel = 100 - data.fuel;
    var percent = fuel/100;
    var gasheigth = $('.gas-wrap').height();
    var progress = percent * gasheigth;
    var animationLength = 50;
    $('.gas-bar').stop().animate({
        height: progress
    }, animationLength);
    if(data.fuel <= 30){
        $('.gas-wrap').css('color','#d1645a');
    }else if(data.fuel > 30 && data.fuel < 60 ){
        $('.gas-wrap').css('color','#dece54');
    }
    else{
        //#459939
        $('.gas-wrap').css('color','white');
    }
    if(data.fuel == 0){
        $('.gas-wrap').css('animation','blinker 1s linear infinite');
    }else{
        $('.gas').css('animation','none'); 
    }
    //------------- Km/h -------------//
    $('.style1').html(`
        <span>${parseInt(data.speed)}</span>
    `);
    //------------- Marcha -------------//
    $('.style3 .controls').html(`
    <span>${data.gear}</span>
    `);
    //------------- Setas -------------//
    switch(data.seta){
        case "esquerda":
            $('.style4 .direita i').css('animation','none');
            $('.style4 .esquerda i').css('animation','seta 1s linear infinite');   
        break;
        case "direita":
            $('.style4 .esquerda i').css('animation','none');
            $('.style4 .direita i').css('animation','seta 1s linear infinite');
        break;
        case "ambas":
            $('.style4 .esquerda i').css('animation','none');
            $('.style4 .direita i').css('animation','none');
            $('.style4 .controls i').css('animation','seta 1s linear infinite');
        break;
        case "none":
            $('.style4 .controls i').css('animation','none');
        break;
    }
    //------------- Farois -------------//
        switch(data.farol){
            case "desligado":
                $(".style2 .flex .controls i").css('color','white');
                $(".style2 .flex .controls i").css('text-shadow','none');
            break;
            case "baixo":
                $(".style2 .flex .controls i").css('color','#57b2c9');
                $(".style2 .flex .controls i").css('text-shadow','none');
            break;
            case "alto":
                $(".style2 .flex .controls i").css('color','#57b2c9');
                $(".style2 .flex .controls i").css('text-shadow','0 0 6px #36f5ff');
            break;
        }
        

}
const atualizarHud = (data) => {
    var calc = data.vida - 101;
    var calcular = calc * 100 / 299
    var seila = calcular / 100;
    var getProgressWrapWidth = $('.progress-wrap').width();
    var progressTotal = seila * getProgressWrapWidth; 
    var armor = data.armor / 100;
    var barlenght = $('.progress-wrap2').width();
    var progressbar = armor * barlenght;
    $('.progress-bar2').stop().animate({
        left: progressbar
    }, 100);

    $('.progress-bar').stop().animate({
        left: progressTotal
    }, 100);
    $('.box1').html(`
    <span>${data.rua}</span>
    <i class="material-icons">mic</i>
    `);
    switch (data.voz){
        case "whisper":
            $('.box1 .material-icons').css('color','#dece54');
        break;
        case "normal":
            $('.box1 .material-icons').css('color','#459939');
        break;
        case "shout":
            $('.box1 .material-icons').css('color','#d1645a');
        break;
    }

}
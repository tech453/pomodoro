// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

var timer,work=25,short_break=5,long_break=15,work_count=0,timer_string,is_work=true,is_counting=false;
function get_timer_string(){
    timer_string=document.querySelector("#timer").textContent;
    timer_string.trim();
    return timer_string
}

var minute,second,minute_string,second_string;    
function get_minute_and_second(){
    minute_string=get_timer_string().slice(0,2);
    second_string=get_timer_string().slice(3,5)
    minute=parseInt(minute_string);
    second=parseInt(second_string);
}

var account_seconds;
function get_account_seconds(){
    get_minute_and_second();
    account_seconds= minute*60+second;
    
    return account_seconds;
}

function set_timer_string(){
    timer_string=minute_string+":"+second_string;
    document.querySelector("#timer").textContent=timer_string;
    return timer_string;
}

function countdown(){
    account_seconds=get_account_seconds()-1;
    minute=Math.floor(account_seconds/60);
    second=account_seconds%60;
    minute_string=('0'+minute).slice(-2);
    second_string=('0'+second).slice(-2);
    if(account_seconds<0){
        clearInterval(timer);
        play();
        

    }else{
        set_timer_string();            
    }

}


function tick(){
    start_button.disabled=true;
    is_counting=true;
    timer=setInterval("countdown()",1);
}

const ctx = new AudioContext();
var oscillator;
var isPlaying = false;

function play(){
      if (isPlaying) return;
      oscillator = ctx.createOscillator();
      oscillator.type = "sine"; 
      oscillator.frequency.setValueAtTime(440, ctx.currentTime); 
      oscillator.connect(ctx.destination);
      oscillator.start();
      isPlaying = true;
}

function stop(){
    clearInterval(timer);
    is_counting=false;
    if(is_work && get_timer_string()=="00:00"){
        work_count+=1;
        is_work=false;
        if(work_count%4!=0){
            minute_string=("0"+String(short_break)).slice(-2);
        }else{
            minute_string=("0"+String(long_break)).slice(-2);
        }
        second_string="00";
        set_timer_string();
        
    }
    if(!is_work && get_timer_string()=="00:00"){
        is_work=true;
        minute_string=("0"+String(work)).slice(-2);
        second_string="00";
        set_timer_string();
    }

    
    start_button.disabled=false;
    oscillator.stop();
    isPlaying = false;
}

function get_today_date(){
    var today=new Date();

    return String(today.getFullYear())+String(today.getMonth())+String(today.getDate());
}

function set_lasttime(event){
  sessionStorage.setItem('lasttime',get_timer_string());
  sessionStorage.setItem('lastvisit',get_today_date());
}

function restore_lasttime(){
    if(sessionStorage.getItem('lastvisit')===get_today_date()){
        $("#timer").text(sessionStorage.getItem('lasttime'));
    }
}
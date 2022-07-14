'use strict';

const loadText = document.querySelector('.loading-text');
const bg = document.querySelector('.bg');

let load = 0; // loading 숫자 초기값 0
let int = setInterval(blurring, 30); // 0.03초(30ms)마다 blurring 함수 실행

function blurring() {
    load++;

    if (load > 99) {
        clearInterval(int); // loading 숫자가 100 이상이면 blurring 함수 종료
    }

    loadText.textContent = `${load}%`;
    // loading 숫자가 0에서 100되는 동안 opacity가 1에서 0으로 변경
    loadText.style.opacity = scale(load, 0, 100, 1, 0);
    // loading 숫자가 0에서 100되는 동안 blur가 30에서 0으로 변경
    bg.style.filter = `blur(${scale(load, 0, 100, 30, 0)}px)`;
}

// https://stackoverflow.com/questions/10756313/javascript-jquery-map-a-range-of-numbers-to-another-range-of-numbers
// 한 레인지(0~100)를 다른 레인지(1~0), (30~0), ...로 변환하는 함수 공식
function scale(number, inMin, inMax, outMin, outMax) {
    return (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
}

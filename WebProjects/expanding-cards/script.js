'use strict';

const panels = document.querySelectorAll('.panel');

// for (let i = 0; i < panels.length; i++) {
//     panels[i].addEventListener('click', function () {
//         removeActiveClass();
//         panels[i].classList.add('active');
//     });
// }

// forEach 반복문
// 객체 panels 안의 panel을 하나씩 꺼내와서 개별로 실행
panels.forEach(function (panel) {
    panel.addEventListener('mouseenter', function () {
        removeActiveClass();    // active class 제거
        panel.classList.add('active');
    });
});

function removeActiveClass() {
    panels.forEach(function (panel) {
        panel.classList.remove('active');
    });
};
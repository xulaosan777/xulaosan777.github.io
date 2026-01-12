// source/js/runtime.js

let lastStates = { d1:0, d2:0, d3:0, h1:0, h2:0, m1:0, m2:0, s1:0, s2:0 };

function updateMechaTimer() {
    // ⚠️ 记得确认这里的建站时间是你的
    let create_time = new Date("2025-12-09T00:00:00"); 
    let now = new Date();
    let difference = now - create_time;

    // 计算天时分秒
    let days = Math.floor(difference / (1000 * 60 * 60 * 24));
    let hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((difference % (1000 * 60)) / 1000);

    let currentStates = {
        d1: String(days).padStart(3, '0').charAt(0),
        d2: String(days).padStart(3, '0').charAt(1),
        d3: String(days).padStart(3, '0').charAt(2),
        h1: String(hours).padStart(2, '0').charAt(0),
        h2: String(hours).padStart(2, '0').charAt(1),
        m1: String(minutes).padStart(2, '0').charAt(0),
        m2: String(minutes).padStart(2, '0').charAt(1),
        s1: String(seconds).padStart(2, '0').charAt(0),
        s2: String(seconds).padStart(2, '0').charAt(1)
    };

    for (let key in currentStates) {
        let element = document.getElementById(key);
        if (!element) continue;

        // 只有当数字发生变化时，才更新
        if (currentStates[key] !== lastStates[key]) {
            element.innerText = currentStates[key];
            
            // 核心修复：添加动画类 -> 500毫秒后移除 -> 等待下一次添加
            // 这样能确保每次变化都必定触发动画
            element.classList.add('shake-digit');
            
            // 使用闭包锁定当前的 element
            (function(el) {
                setTimeout(() => {
                    el.classList.remove('shake-digit');
                }, 500); // 0.5秒后移除，跟CSS动画时长匹配
            })(element);
        }
    }
    lastStates = currentStates;
}

document.addEventListener('DOMContentLoaded', (event) => {
    setInterval(updateMechaTimer, 1000);
});
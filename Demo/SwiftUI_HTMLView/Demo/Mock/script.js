document.addEventListener("DOMContentLoaded", function() {
    const bars = document.querySelectorAll('.bar');
    document.getElementById('playButton').onclick = function() {
        bars.forEach(bar => {
            bar.style.animationPlayState = 'running';
        });
    };
    document.getElementById('stopButton').onclick = function() {
        bars.forEach(bar => {
            bar.style.animationPlayState = 'paused';
        });
    };
});

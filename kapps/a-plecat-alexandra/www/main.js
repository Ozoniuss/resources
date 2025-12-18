const target = new Date('2026-01-14T15:00:00Z');

function update() {
  const now = new Date();

  if (now > target) {
    document.getElementById('asacumammaizis').textContent = "DA !!!"
    document.getElementById('counter').textContent =
      ``;
  } else {
    let diff = Math.max(0, target - now);
  
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    diff %= 1000 * 60 * 60 * 24;
  
    const hours = Math.floor(diff / (1000 * 60 * 60));
    diff %= 1000 * 60 * 60;
  
    const minutes = Math.floor(diff / (1000 * 60));
    diff %= 1000 * 60;
  
    const seconds = Math.floor(diff / 1000);
  
    document.getElementById('counter').textContent =
      `${days}d ${hours}h ${minutes}m ${seconds}s`;
  }

}

update();
setInterval(update, 1000);

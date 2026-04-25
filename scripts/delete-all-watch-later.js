(function clearWatchLater() {
  const delay = 600;

  let interval = setInterval(() => {
    const video = document.querySelector('ytd-playlist-video-renderer');
    if (!video) {
      clearInterval(interval);
      return;
    }

    const menuBtn = video.querySelector('#primary button[aria-label="Action menu"]');
    if (!menuBtn) {
      return;
    }
    menuBtn.click();

    setTimeout(() => {
      const remove = Array.from(document.querySelectorAll('tp-yt-paper-item, ytd-menu-service-item-renderer'))
        .find(el => /remove from watch later/i.test(el.innerText));
      if (remove) {
        remove.click();
      }
    }, 300);
  }, delay);
})();

// Immersive Enhancements for Oltre Way Dispatch Pages

(function() {
  // Track scroll position for progress bar and parallax
  let scrollProgress = 0;

  // Create and inject reading progress bar
  function initProgressBar() {
    const progressBar = document.createElement('div');
    progressBar.id = 'reading-progress';
    progressBar.style.cssText = `
      position: fixed;
      top: 0;
      left: 0;
      height: 3px;
      background: linear-gradient(90deg, #6B2737, #C4724E);
      z-index: 1000;
      width: 0%;
      transition: width 0.1s ease;
    `;
    document.body.insertBefore(progressBar, document.body.firstChild);

    window.addEventListener('scroll', () => {
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      scrollProgress = (window.scrollY / docHeight) * 100;
      progressBar.style.width = scrollProgress + '%';
    });
  }

  // Create fixed nav header that appears on scroll
  function initFixedNav() {
    const nav = document.createElement('nav');
    nav.id = 'fixed-nav';
    nav.style.cssText = `
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      background: rgba(250, 247, 242, 0.98);
      backdrop-filter: blur(10px);
      padding: 16px 20px;
      z-index: 999;
      border-bottom: 1px solid #D4C9BC;
      transform: translateY(-100%);
      transition: transform 0.3s ease;
      display: flex;
      justify-content: space-between;
      align-items: center;
    `;

    const brand = document.createElement('a');
    brand.href = 'index.html';
    brand.style.cssText = `
      font-family: 'Playfair Display', serif;
      font-size: 14px;
      font-weight: 400;
      letter-spacing: 2px;
      color: #6B2737;
      text-decoration: none;
      text-transform: uppercase;
    `;
    brand.textContent = 'The Oltre Way';

    const homeLink = document.createElement('a');
    homeLink.href = 'index.html';
    homeLink.style.cssText = `
      font-family: 'Cormorant Garamond', serif;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 1px;
      color: #6B2737;
      text-decoration: none;
      text-transform: uppercase;
      transition: color 0.3s ease;
    `;
    homeLink.textContent = '← Back to Index';
    homeLink.onmouseover = () => homeLink.style.color = '#C4724E';
    homeLink.onmouseout = () => homeLink.style.color = '#6B2737';

    nav.appendChild(brand);
    nav.appendChild(homeLink);
    document.body.insertBefore(nav, document.body.firstChild);

    // Show nav on scroll
    window.addEventListener('scroll', () => {
      const hero = document.querySelector('.hero');
      if (hero) {
        const heroBottom = hero.offsetHeight;
        if (window.scrollY > heroBottom * 0.3) {
          nav.style.transform = 'translateY(0)';
        } else {
          nav.style.transform = 'translateY(-100%)';
        }
      }
    });
  }

  // Parallax effect for hero background
  function initHeroParallax() {
    const hero = document.querySelector('.hero');
    const heroBg = document.querySelector('.hero-bg');

    if (hero && heroBg) {
      window.addEventListener('scroll', () => {
        const heroRect = hero.getBoundingClientRect();
        const scrolled = window.scrollY;

        // Only apply parallax while hero is in view
        if (heroRect.bottom > 0) {
          const parallaxAmount = scrolled * 0.5;
          heroBg.style.transform = `translateY(${parallaxAmount}px)`;
        }
      });
    }
  }

  // Scroll-triggered animations using Intersection Observer
  function initScrollAnimations() {
    const observerOptions = {
      threshold: 0.15,
      rootMargin: '0px 0px -80px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.style.opacity = '1';
          entry.target.style.transform = 'translateY(0)';
        }
      });
    }, observerOptions);

    // Observe all elements that should fade in on scroll
    const elementsToAnimate = document.querySelectorAll(
      '.article-body p, .pull-quote, .section-break, .lineup-card, .points-card, ' +
      '.wine-card, .cost-aside, .image-pair, .image-full, .golden-body p, ' +
      '.article-body-night p, .departure-body p'
    );

    elementsToAnimate.forEach(el => {
      el.style.opacity = '0';
      el.style.transform = 'translateY(24px)';
      el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
      observer.observe(el);
    });
  }

  // Wire up series navigation links
  function initSeriesNav() {
    const seriesNav = document.querySelector('.series-nav');
    if (!seriesNav) return;

    // Define series order
    const series = [
      'miami-article.html',
      'miami-sunday-article.html',
      'miami-part3.html',
      'miami-part4.html'
    ];

    // Get current page
    const currentPage = window.location.pathname.split('/').pop();

    const links = seriesNav.querySelectorAll('a');
    links.forEach(link => {
      const label = link.querySelector('.series-label')?.textContent;

      if (label?.includes('Previous')) {
        const currentIndex = series.findIndex(page => page === currentPage);
        if (currentIndex > 0) {
          link.href = series[currentIndex - 1];
        }
      } else if (label?.includes('Next')) {
        const currentIndex = series.findIndex(page => page === currentPage);
        if (currentIndex < series.length - 1 && currentIndex !== -1) {
          link.href = series[currentIndex + 1];
        }
      } else if (label?.includes('Series')) {
        link.href = 'index.html';
      }
    });
  }

  // Initialize all enhancements when DOM is ready
  function init() {
    initProgressBar();
    initFixedNav();
    initHeroParallax();
    initScrollAnimations();
    initSeriesNav();
  }

  // Run when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();

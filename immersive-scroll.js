/**
 * Immersive Scrolling & Interaction System
 * Creates ethereal, luxe scrolling experiences with color transitions
 */

(function() {
  'use strict';

  // Color palette configurations for different article moods
  const articleColorSchemes = {
    'tam-tam-to-sunrise': {
      name: 'Night to Dawn Transition',
      colors: [
        { pos: 0, color: 'rgb(10, 10, 25)' },      // deep midnight
        { pos: 0.25, color: 'rgb(20, 15, 45)' },   // dark indigo
        { pos: 0.5, color: 'rgb(60, 30, 60)' },    // deep purple
        { pos: 0.75, color: 'rgb(200, 120, 140)' }, // rose mauve
        { pos: 1, color: 'rgb(255, 200, 200)' }    // cotton candy pink
      ]
    },
    'andaz-epilogue': {
      name: 'Beach Recovery to Warmth',
      colors: [
        { pos: 0, color: 'rgb(245, 240, 232)' },   // warm cream
        { pos: 0.5, color: 'rgb(230, 200, 180)' }, // sandy gold
        { pos: 1, color: 'rgb(210, 170, 150)' }    // warm terracotta
      ]
    },
    'sunday-in-miami': {
      name: 'Afternoon Sophistication',
      colors: [
        { pos: 0, color: 'rgb(245, 240, 232)' },   // cream
        { pos: 0.5, color: 'rgb(200, 180, 160)' }, // taupe
        { pos: 1, color: 'rgb(220, 150, 120)' }    // sunset coral
      ]
    },
    'jackson-hole': {
      name: 'Mountain Snow & Sky',
      colors: [
        { pos: 0, color: 'rgb(240, 245, 250)' },   // snowy white
        { pos: 0.5, color: 'rgb(180, 200, 220)' }, // sky blue
        { pos: 1, color: 'rgb(100, 150, 200)' }    // deep alpine
      ]
    },
    'banff-lake-louise': {
      name: 'Alpine Majesty',
      colors: [
        { pos: 0, color: 'rgb(250, 245, 240)' },   // cream
        { pos: 0.5, color: 'rgb(180, 210, 230)' }, // glacier blue
        { pos: 1, color: 'rgb(90, 140, 180)' }     // deep mountain
      ]
    },
    default: {
      name: 'Warm Luxury',
      colors: [
        { pos: 0, color: 'rgb(254, 253, 251)' },   // off-white
        { pos: 0.5, color: 'rgb(230, 210, 190)' }, // warm taupe
        { pos: 1, color: 'rgb(210, 170, 140)' }    // rich brown
      ]
    }
  };

  // Get the article type from the page
  function getArticleType() {
    const filename = window.location.pathname.split('/').pop();

    if (filename.includes('miami-part3') || filename.includes('tam-tam')) {
      return 'tam-tam-to-sunrise';
    } else if (filename.includes('miami-part4') || filename.includes('andaz')) {
      return 'andaz-epilogue';
    } else if (filename.includes('sunday')) {
      return 'sunday-in-miami';
    } else if (filename.includes('jackson')) {
      return 'jackson-hole';
    } else if (filename.includes('banff')) {
      return 'banff-lake-louise';
    }
    return 'default';
  }

  // Interpolate between colors
  function interpolateColor(color1, color2, factor) {
    const c1 = color1.match(/\d+/g).map(Number);
    const c2 = color2.match(/\d+/g).map(Number);

    const r = Math.round(c1[0] + (c2[0] - c1[0]) * factor);
    const g = Math.round(c1[1] + (c2[1] - c1[1]) * factor);
    const b = Math.round(c1[2] + (c2[2] - c1[2]) * factor);

    return `rgb(${r}, ${g}, ${b})`;
  }

  // Get color based on scroll position
  function getColorForScroll(scrollPercent, colorScheme) {
    const colors = colorScheme.colors;

    for (let i = 0; i < colors.length - 1; i++) {
      const current = colors[i];
      const next = colors[i + 1];

      if (scrollPercent >= current.pos && scrollPercent <= next.pos) {
        const range = next.pos - current.pos;
        const factor = (scrollPercent - current.pos) / range;
        return interpolateColor(current.color, next.color, factor);
      }
    }

    return colors[colors.length - 1].color;
  }

  // Initialize scroll-based color transitions
  function initScrollColorTransition() {
    const articleType = getArticleType();
    const colorScheme = articleColorSchemes[articleType] || articleColorSchemes.default;
    const body = document.body;

    // Create a style element for smooth transitions
    const style = document.createElement('style');
    style.textContent = `
      body {
        transition: background-color 0.05s ease-out;
      }
    `;
    document.head.appendChild(style);

    // Update background color on scroll
    let ticking = false;

    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
          const scrollPercent = scrollHeight > 0 ? window.scrollY / scrollHeight : 0;

          const color = getColorForScroll(Math.min(scrollPercent, 1), colorScheme);
          body.style.backgroundColor = color;

          ticking = false;
        });
        ticking = true;
      }
    });

    // Set initial color
    body.style.backgroundColor = colorScheme.colors[0].color;
  }

  // Enhanced interactive elements
  function initInteractiveElements() {
    // Style for interactive elements
    const style = document.createElement('style');
    style.textContent = `
      /* Interactive element enhancements */
      a, button, .interactive {
        position: relative;
        transition: all 0.4s cubic-bezier(0.23, 1, 0.320, 1);
      }

      /* Hover glow effect */
      a:hover, button:hover, .dispatch-card:hover {
        text-shadow: 0 0 12px rgba(201, 169, 110, 0.4);
        filter: drop-shadow(0 0 8px rgba(201, 169, 110, 0.3));
        transform: scale(1.02);
      }

      /* CTA buttons */
      .hero-cta, .dispatch-card-link {
        position: relative;
        overflow: hidden;
      }

      /* Click ripple effect */
      a::before, button::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(201, 169, 110, 0.3);
        transform: translate(-50%, -50%);
        pointer-events: none;
      }

      /* Backdrop blur for cards */
      .chart-container, .dispatch-card, .philosophy-quote {
        backdrop-filter: blur(8px);
      }

      /* Text glow on focus */
      a:focus, button:focus {
        outline: none;
        text-shadow: 0 0 20px rgba(201, 169, 110, 0.5);
      }

      /* Smooth fade-in for elements */
      .fade-in {
        animation: fadeInSmooth 0.6s ease-out forwards;
      }

      @keyframes fadeInSmooth {
        from {
          opacity: 0;
          transform: translateY(20px);
          filter: blur(4px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
          filter: blur(0);
        }
      }

      /* Liquid glass effect for modals/overlays */
      .glass-modal {
        background: rgba(255, 255, 255, 0.08);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 12px;
      }

      /* Subtle layered shadows */
      .elevated {
        box-shadow:
          0 8px 16px rgba(0, 0, 0, 0.1),
          0 4px 8px rgba(0, 0, 0, 0.08),
          0 2px 4px rgba(0, 0, 0, 0.06);
      }

      /* Smooth scroll behavior */
      html {
        scroll-behavior: smooth;
      }
    `;
    document.head.appendChild(style);

    // Add ripple effect on click
    document.addEventListener('click', (e) => {
      const target = e.target;
      if (target.matches('a, button, .interactive')) {
        const rect = target.getBoundingClientRect();
        const ripple = document.createElement('span');
        ripple.style.cssText = `
          position: absolute;
          top: ${e.clientY - rect.top}px;
          left: ${e.clientX - rect.left}px;
          width: 0;
          height: 0;
          border-radius: 50%;
          background: rgba(201, 169, 110, 0.5);
          pointer-events: none;
          animation: ripple 0.6s ease-out;
        `;

        // Add ripple animation
        const style = document.createElement('style');
        style.textContent = `
          @keyframes ripple {
            to {
              width: 300px;
              height: 300px;
              opacity: 0;
            }
          }
        `;
        document.head.appendChild(style);

        if (target.position !== 'static' && target.position !== 'relative' && target.position !== 'absolute') {
          target.style.position = 'relative';
        }
        target.appendChild(ripple);
      }
    });
  }

  // Parallax effect for hero backgrounds
  function initParallax() {
    const hero = document.querySelector('.hero');
    const heroBg = document.querySelector('.hero-bg');

    if (hero && heroBg) {
      window.addEventListener('scroll', () => {
        const heroRect = hero.getBoundingClientRect();
        if (heroRect.bottom > 0) {
          const scrolled = window.scrollY;
          const parallaxAmount = scrolled * 0.3;
          heroBg.style.transform = `translateY(${parallaxAmount}px)`;
        }
      });
    }
  }

  // Enhanced reading progress bar
  function initProgressBar() {
    let progressBar = document.getElementById('reading-progress');

    if (!progressBar) {
      progressBar = document.createElement('div');
      progressBar.id = 'reading-progress';
      progressBar.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        height: 2px;
        background: linear-gradient(90deg,
          rgba(201, 169, 110, 0.8) 0%,
          rgba(220, 150, 120, 0.8) 50%,
          rgba(201, 169, 110, 0.8) 100%);
        z-index: 1000;
        width: 0%;
        box-shadow: 0 0 20px rgba(201, 169, 110, 0.5);
        transition: width 0.1s ease-out, box-shadow 0.3s ease;
      `;
      document.body.insertBefore(progressBar, document.body.firstChild);
    }

    window.addEventListener('scroll', () => {
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      const scrollPercent = docHeight > 0 ? (window.scrollY / docHeight) * 100 : 0;
      progressBar.style.width = scrollPercent + '%';

      // Enhance glow at higher scroll
      const glowIntensity = (scrollPercent / 100) * 0.5 + 0.3;
      progressBar.style.boxShadow = `0 0 ${20 * glowIntensity}px rgba(201, 169, 110, ${glowIntensity})`;
    });
  }

  // Smooth text reveal on scroll
  function initTextReveal() {
    const style = document.createElement('style');
    style.textContent = `
      .article-body p, .article-body .pull-quote, .section-break {
        opacity: 0.7;
        transition: opacity 0.4s ease, text-shadow 0.4s ease;
      }

      .article-body p:hover, .article-body .pull-quote:hover {
        opacity: 1;
        text-shadow: 0 0 8px rgba(201, 169, 110, 0.2);
      }
    `;
    document.head.appendChild(style);
  }

  // Initialize all enhancements
  function init() {
    // Check if we're on a dispatch article
    const filename = window.location.pathname.split('/').pop();
    const isDispatch = filename.includes('dispatch') || filename.includes('article') || filename.includes('miami-part');

    if (isDispatch) {
      initScrollColorTransition();
      initParallax();
    }

    initInteractiveElements();
    initProgressBar();
    initTextReveal();
  }

  // Run when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();

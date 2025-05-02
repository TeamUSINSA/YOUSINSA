
<style>
  .scroll-top-btn {
    position: fixed;
    bottom: 40px;
    right: 20px;           /* 오른쪽에서 20px 떨어지도록 */
    z-index: 1000;
    width: 48px;
    height: 48px;
    border: none;
    border-radius: 50%;
    background: #303030;
    color: #fff;
    font-size: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.3);
  }
  .scroll-top-btn:hover {
    opacity: 0.8;
  }
</style>

<button
  id="scrollTopBtn"
  class="scroll-top-btn"
  title="맨 위로"
  type="button"
>
  &#x2191;  <!-- 위쪽 화살표 엔티티 -->
</button>

<script>
  document.addEventListener('DOMContentLoaded', function(){
    const btn = document.getElementById('scrollTopBtn');
    btn.addEventListener('click', function(){
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  });
</script>

const style = '''* {
  margin: 0;
  padding: 0;
  font-family: 'Poppins', sans-serif;
}

body {
  background-color: #ff99f5;
  background-image:
      radial-gradient(at 61% 4%, hsla(303, 91%, 61%, 1) 0px, transparent 50%),
      radial-gradient(at 75% 66%, hsla(196, 91%, 79%, 1) 0px, transparent 50%),
      radial-gradient(at 98% 88%, hsla(76, 87%, 78%, 1) 0px, transparent 50%),
      radial-gradient(at 23% 16%, hsla(238, 96%, 77%, 1) 0px, transparent 50%),
      radial-gradient(at 95% 65%, hsla(13, 91%, 75%, 1) 0px, transparent 50%),
      radial-gradient(at 10% 79%, hsla(228, 96%, 69%, 1) 0px, transparent 50%),
      radial-gradient(at 85% 58%, hsla(328, 81%, 68%, 1) 0px, transparent 50%);
  background-repeat: no-repeat;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 15rem 0;
}

.card {
  backdrop-filter: blur(16px) saturate(180%);
  -webkit-backdrop-filter: blur(16px) saturate(180%);
  background-color: rgba(0, 0, 0, 0.75);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.125);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 30px 40px;
}

.lock-icon {
  font-size: 3rem;
}

h2 {
  font-size: 1.5rem;
  margin-top: 10px;
  text-transform: uppercase;
}

p {
  font-size: 12px;
}

.passInput {
  margin-top: 15px;
  width: 80%;
  background: transparent;
  border: none;
  border-bottom: 2px solid deepskyblue;
  font-size: 15px;
  color: white;
  outline: none;
}

button {
  margin-top: 15px;
  width: 80%;
  background-color: deepskyblue;
  color: white;
  padding: 10px;
  text-transform: uppercase;
}

''';

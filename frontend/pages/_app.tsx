import "@/styles/globals.css";
import type { AppProps } from "next/app";
import NavBar from "@/components/NavBar/NavBar";
import { Footer } from "@/components/componentindex";
const App = ({ Component, pageProps }: AppProps) => (
  <>
    <NavBar />
    <Component {...pageProps} />
    <Footer />
  </>
);

export default App;

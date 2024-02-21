public class BitcoinFibonacci {

    // Método para calcular el n-ésimo número de Fibonacci de manera iterativa
    public static int fibonacciIterativo(int n) {
        if (n <= 1) return n;
        
        int a = 0, b = 1, c;
        for (int i = 2; i <= n; i++) {
            c = a + b;
            a = b;
            b = c;
        }
        return b;
    }

    public static void main(String[] args) {
        double precioInicialBtc = 20000; // Precio inicial de Bitcoin
        int n = 10; // Calcularemos los precios para los primeros 10 números de Fibonacci
        double factor = 100; // Factor de cambio por cada número de Fibonacci

        System.out.println("Precio inicial de BTC: $" + precioInicialBtc);
        for (int i = 1; i <= n; i++) {
            int fib = fibonacciIterativo(i);
            double cambioPrecio = fib * factor;
            precioInicialBtc += cambioPrecio;
            System.out.println("F(" + i + ") = " + fib + "; Nuevo precio de BTC: $" + precioInicialBtc);
        }
    }
}

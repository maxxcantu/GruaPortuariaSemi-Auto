# Control Semi-Automático coordinado de grúa portuaria de muelle tipo pórtico

En el presente proyecto se realizó el modelado, desarrollo, implementación y simulación de un autómata híbrido de control para operación semi-automática coordinada en grúa portuaria de muelle tipo portico. El sistema cuenta con dos movimientos: uno de traslación del carro y otro de izaje de la carga. Se modelaron estos dos sistemas junto al del movimiento de la carga teniendo en cuenta la elasticidad de los cables (del carro y de izaje).

El control se realizó en tres niveles: control regulatorio (nivel 2), control supervisor (nivel 1) y control de seguridad (nivel 0). El control regulatorio, se compone por dos controladores PID que reciben la consigna de velocidad, tanto para el carro, como para el izaje y devuelven los torques correspondientes. Se modeló un controlador PD para controlar el ángulo de balanceo de la carga. Luego, el control supervisor, que se encarga de enviar las consignas según el movimiento en modo automatico o manual, en estado de operación normal. Por último, se implementó el sistema de seguridad diseñado para tomar el mando del sistema cuando se produzca alguna emergencia.

El proyecto se realizó en 2 etapas de desarrollo:
A) Diseño, modelado conceptual y análisis de desempeño mediante simulación ”Model-in-the-loop”. En donde, los Niveles 0 y 1 de estados discretos activados por eventos, se implementaron en StateFlow; y, el Nivel 2 de estados continuos en tiempo discretizados, así como la Planta de estados continuos en tiempo continuo, se implementaron en Simulink.

B) Implementacion del Sistema Híbrido de Control y Protección en entorno de desarrollo y programacion para Controladores Digitales Programables industriales según Norma IEC 61131 (CODESYS) y co-simulación ”Software-in-the-loop”, donde los Niveles 0 y 1 se implementan en CODESYS; y, son comunicados mediante cliente/servidor al desarrollo de la Planta y el Nivel 2 en Simulink, según estándar OPC UA(Unified Architecture).

function grafico_puerto(clock, ON_OFF, BTN_EMERGENCIA, Manual, Ciclo, max_masa, Tension_hw, lim_v_h, Balanceo, manual_auto, ml_medida, xc, yc, graficar, x_l, y_l, x_td)
if(graficar==1)
    alt_txt = 14;   color_cont = "#90AC50";
    fh = figure(100);
    fh.WindowState = 'maximized';
    clf(fh);
    title('Simulación Visual en Tiempo "Real"'),    grid on
    rectangle('Position',[-30, 46, 80, 4],'FaceColor', '#EEEEEE','EdgeColor','#EEEEEE')
    rectangle('Position',[-30, -20, 30, 20],'FaceColor', 'w')
    line([-30 0],[-0.5 -0.5],'Color','black','LineWidth', 5)                    %%% Muelle
    rectangle('Position',[-0.5, 0, 0.5, 15],'FaceColor','black');               %%% Sill Beam
    rectangle('Position',[0.5, -20, 49.5, 25],'EdgeColor','b','LineWidth', 1.5);%%% Barco
    rectangle('Position',[-30, 45, 80, 2],'FaceColor',[0.8 0.8 1]);             %%% Grúa
    rectangle('Position',[x_l-1.25,y_l,2.5,0.5],'FaceColor','k');               %%% Spreader
    rectangle('Position',[x_td-2.5, 45, 5, 2],'FaceColor','k');              %%% Carro
    line([x_l x_td], [y_l 45],'Color','black','LineWidth',2)                 %%% Cable

    for i=1:length(yc)                  %%% Perfil de Carga
        if (xc(i)<2.5)                  %%% Lado de Muelle
            rectangle('Position',[xc(i)-1.25,0,2.5,yc(i)],'FaceColor', color_cont,'LineWidth', 0.3);
        elseif(xc(i)>2.5 && xc(i)<47.5) %%% Lado de Barco
            rectangle('Position',[xc(i)-1.25,-20,2.5,yc(i)+20],'FaceColor', color_cont,'LineWidth', 0.3);
        end
    end

    txt000 = {'Tiempo: ', clock};       %%% Tiempo de Ejecución "Real"
    text(-10, -3.5, txt000,'FontSize', alt_txt)

    if(ON_OFF)                          %%% Cartel de ON - OFF
        txt00 = {'ON: Encendido'};
        text(-30,48.5,txt00,'FontSize',alt_txt,'Color',"#00AA00")
    else
        txt00 = {'OFF: APAGADO'};
        text(-30,48.5,txt00,'FontSize',alt_txt,'Color',"#FF0000")
    end
    
    txt = {'Masa: ', ml_medida};               %%% Cartel de Masa Total en Spreader
    text(-29.75,-17,txt,'FontSize',alt_txt)

    if (ml_medida > 15000)                       %%% Cartel de Cargado/Sin Carga/SOBRECARGA
        rectangle('Position',[x_l-1.25,y_l-2.5,2.5,2.5],'FaceColor', color_cont,'LineWidth', 0.3); %carga
        if (max_masa)
            txt01 = {'SOBRECARGA'};
            text(-25,-17,txt01,'Color','red','FontSize',alt_txt+2)
        else
            txt01 = {'Cargado'};
            text(-25,-17,txt01,'Color',"#00AA00",'FontSize',alt_txt)
        end
    else
        txt01 = {'Sin Carga'};
        text(-25,-17,txt01,'Color',"#CB7A00",'FontSize',alt_txt)
    end

    if (Manual)                       %%% Cartel de Modo de Control
        txt02 = {'Manual'};
        text(-15, 48.5,txt02,'FontSize', alt_txt)
    else
        if (manual_auto)
            txt02 = {'Automático'};
            text(-15, 48.5,txt02,'FontSize',alt_txt)
        else
            txt02 = {'Manual'};
            text(-15, 48.5,txt02,'FontSize',alt_txt)
        end
    end

    if (Balanceo)                       %%% Cartel de Control de Balanceo
        txt03 = {'Balanceo: ON'};
        text(-4, 48.5, txt03,'FontSize',alt_txt,'Color',"#00AA00")
    else
        txt03 = {'Balanceo: OFF'};
        text(-4, 48.5,txt03,'FontSize', alt_txt,'Color','#FF0000')
    end

    if (Tension_hw)                     %%% Cartel de Spreader Apoyado o Suspendido
        txt04 = {'Suspendido'};
        text(10,48.5,txt04,'FontSize', alt_txt)
    else
        txt04 = {'Apoyado'};
        text(10,48.5,txt04,'FontSize', alt_txt)
    end

    if (Ciclo)                          %%% Cartel de Tipo de Ciclo
        txt05 = {'Ciclo Doble'};
        text(22,48.5,txt05,'FontSize', alt_txt)
    else
        txt05 = {'Ciclo Simple'};
        text(22,48.5,txt05,'FontSize', alt_txt)
    end
    
    if (BTN_EMERGENCIA)                 %%% Cartel de EMERGENCIA (botón)
        txt7 = {'EMERGENCIA'};
        rectangle('Position',[34.5, 47, 15.5, 3],'FaceColor', 'red')
        text(35.5,48.5,txt7,'FontSize', alt_txt+6,'Color',"w")
    else
        txt7 = {'OK'};
        rectangle('Position',[34.5, 47, 15.5, 3],'FaceColor', "#00FF00")
        text(41,48.5,txt7,'FontSize', alt_txt+6,'Color',"k")
    end
  
    txt1 = {'Carro (X): ',x_td};                %%% Posiciones del Carro
    text(-29.75,-3.5,txt1,'FontSize',alt_txt)
    txt1 = {'Carro (Y): ',45};
    text(-20,-3.5,txt1,'FontSize',alt_txt)
    txt1 = {'Spreader (X): ',x_l};              %%% Posiciones del Spreader
    text(-29.75,-10,txt1,'FontSize',alt_txt)
    txt1 = {'Spreader (Y): ',y_l};
    text(-20,-10,txt1,'FontSize',alt_txt)
end
end
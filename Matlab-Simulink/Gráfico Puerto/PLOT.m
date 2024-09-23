function PLOT(clock, SYS_ON, SYS_FAULT, BTN_EMERGENCIA, CTRL_MAN, CCL_DB, OW, Tension_hw, O_SPEED, Balanceo, MAN_AUTO, ML, Xc, Yc, flag_plot, x_l, y_l, X_carro)
    if(flag_plot==1)
        h_letra = 14;        
        figure(23);
        clf('reset')
        rectangle('Position',[60,-30,40,100],'FaceColor','w','LineWidth', 0.3); %fondo blanco
        rectangle('Position',[-40,-30,100,100],'FaceColor','w','LineWidth', 0.3); %fondo blanco
        
        rectangle('Position',[-40,-30,45,30],'FaceColor',[0.4 .4 .4],'EdgeColor',[0.4 .4 .4]);  % creo el piso
        rectangle('Position',[0,-30,60,25],'FaceColor',[0.3010 0.7450 0.9330],'LineWidth', 0.1,'EdgeColor',[0.2 .1 .9] ); % creo el mar
        rectangle('Position',[1,-20,48,25],'FaceColor','w','LineWidth', 0.3); %barco
        
        % Grua
        rectangle('Position',[-35,45,95,2],'FaceColor',[0.4660 0.6740 0.1880]); %viga principal
        rectangle('Position',[-35,0,2,60],'FaceColor',[0.4660 0.6740 0.1880]); %columna 1
        rectangle('Position',[-2,0,2,45],'FaceColor','none','LineStyle','--','EdgeColor',[0.4660 0.6740 0.1880]); %columna 2 punteada
        rectangle('Position',[-2,0,2,45],'FaceColor',[0.4660 0.6740 0.1880]); %columna 2 rigida
        
        line([-35 0],[60 47],'Color','black','LineStyle','-')
        line([-35 60],[60 47],'Color','black','LineStyle','-')
        
        rectangle('Position',[-1,0,1,15],'FaceColor','r','EdgeColor',[0.4 .4 .4]); %(viga testera: Ysb =+15m)
        
        rectangle('Position',[x_l-1.25,y_l,2.5,0.5],'FaceColor',[0.4 .4 .4],'EdgeColor',[0.4 .4 .4]);  % spreader
        rectangle('Position',[X_carro-1.25,45,2.5,0.5],'FaceColor',[0.4 .4 .4],'EdgeColor',[0.4 .4 .4]);  % carro
        
        x = [x_l X_carro];
        y = [y_l 45];
        line(x,y,'Color','black','LineStyle','-')
        
        txt000 = {'RELOJ (seg.): ', clock};
        text(65,65,txt000,'FontSize',14)
        
        if(SYS_ON)
            txt00 = {'SISTEMA -> ENCENDIDO'};
            text(65,55,txt00,'FontSize',14,'Color',[0.4660 0.6740 0.1880])
        else
            txt00 = {'SISTEMA -> APAGADO'};
            text(65,55,txt00,'FontSize',14,'Color','red')
        end
        
        
        if (ML>15000)
            rectangle('Position',[x_l-1.25,y_l-2.5,2.5,2.5],'FaceColor',[0.8500 0.3250 0.0980],'LineWidth', 0.3); %carga
            if (OW)
                txt01 = {'cargado (SOBRECARGA)'};
                text(65,50,txt01,'Color','red','FontSize',h_letra)
            else
                txt01 = {'cargado (ADMISIBLE)'};
                text(65,50,txt01,'FontSize',h_letra,'Color',[0.4660 0.6740 0.1880])
            end
            
        else
            txt01 = {'SIN CARGA'};
            text(65,50,txt01,'FontSize',h_letra)
        end
        
        [a,b]=size(Yc);
        
        for i=1:b
            if (Xc(i)<2.5)
                rectangle('Position',[Xc(i)-1.25,0,2.5,Yc(i)],'FaceColor',[0.8500 0.3250 0.0980],'LineWidth', 0.3); %carga
            elseif(Xc(i)>2.5 && Xc(i)<47.5)
                rectangle('Position',[Xc(i)-1.25,-20,2.5,Yc(i)+20],'FaceColor',[0.8500 0.3250 0.0980],'LineWidth', 0.3); %carga
            end
        end

        txt1 = {'X load: ',x_l};
        text(-20,65,txt1,'FontSize',h_letra)
        txt1 = {'Y load: ',y_l};
        text(0,65,txt1,'FontSize',h_letra)
        txt1 = {'X trolley: ',X_carro};
        text(20,65,txt1,'FontSize',h_letra)
        txt1 = {'Y trolley: ',45};
        text(40,65,txt1,'FontSize',h_letra)

        if (CTRL_MAN)
            txt02 = {'CTRL. -> MANUAL'};
            text(65,45,txt02,'FontSize',h_letra)
        else
            if (MAN_AUTO)
                txt02 = {'CTRL. -> SEMI-AUTO. (AUTO)'};
                text(65,45,txt02,'FontSize',h_letra)
            else
                txt02 = {'CTRL. -> SEMI-AUTO. (MANUAL)'};
                text(65,45,txt02,'FontSize',h_letra)
            end
        end

        if (Balanceo)
            txt03 = {'CTRL. BAL. -> ACT.'};
            text(65,40,txt03,'FontSize',h_letra,'Color',[0.4660 0.6740 0.1880])
        else
            txt03 = {'CTRL. BAL. -> DES.'};
            text(65,40,txt03,'FontSize',h_letra,'Color','red')
        end
        
        if (Tension_hw)
            txt04 = {'SPREADER -> SUSPENDIDA'};
            text(65,35,txt04,'FontSize',h_letra)
        else
            txt04 = {'SPREADER -> APOYADA'};
            text(65,35,txt04,'FontSize',h_letra)
        end
        
        if (CCL_DB)
            txt05 = {'CICLO -> DOBLE'};
            text(65,20,txt05,'FontSize',h_letra)
        else
            txt05 = {'CICLO -> SIMPLE'};
            text(65,20,txt05,'FontSize',h_letra)
        end
        
        
        if (O_SPEED)
            txt06 = {'cargado (VEL.CRÍTICA)'};
            text(65,5,txt06,'FontSize',14,'Color','red')
        else
            txt06 = {'cargado (ESTABLE)'};
            text(65,5,txt06,'Color',[0.4660 0.6740 0.1880],'FontSize',14)
        end

        if (BTN_EMERGENCIA)
            txt7 = {'STOP BTN -> ACT.'};
            text(65,0,txt7,'Color','red','FontSize',14)
        else
            txt7 = {'STOP BTN -> DES.'};
            text(65,0,txt7,'FontSize',14,'Color',[0.4660 0.6740 0.1880])
        end
        
        if (SYS_FAULT(1))
            txt8 = {'SIN ALARMAS'};
            text(65,-15,txt8,'FontSize',14,'Color',[0.4660 0.6740 0.1880])
        else
            txt8 = {'sistOK ACTIVADA'};
            text(65,-15,txt8,'Color','red','FontSize',14)
            if(SYS_FAULT(2))
                if(SYS_FAULT(5))
                    text(65,-20,("WATCHDOG"),'Color','red','FontSize',14)
                else
                    text(65,-20,("GENERAL"),'Color','red','FontSize',14)
                end
            elseif(SYS_FAULT(3))
                text(65,-20,("TRASLACION"),'Color','red','FontSize',14)
            elseif(SYS_FAULT(4))
                text(65,-20,("IZAJE"),'Color','red','FontSize',14)
            end
            
        end

    end
end
clear all 
close all

insert(py.sys.path, int32(0),'C:\Users\Kacper\AppData\Local\Programs\Python\Python37\Lib\site-packages\carla-0.9.15-py3.7-win-amd64.egg')

py.importlib.import_module('carla')

port = int16(2000);
client = py.carla.Client('localhost',port);
client.set_timeout(60.0);
world = client.get_world();

pause(2);
client.load_world('Town05');
pause(7);
bib = world.get_blueprint_library();

spawn_points = world.get_map().get_spawn_points();

pojazd_bib = bib.find('vehicle.lincoln.mkz_2020');
miejsce = spawn_points{8};

pojazd = world.try_spawn_actor(pojazd_bib, miejsce);



spectator = world.get_spectator();

pojazd_transform = pojazd.get_transform();
new_location = py.carla.Location(pojazd_transform.location.x -1, pojazd_transform.location.y , pojazd_transform.location.z + 2.5);
transform = py.carla.Transform(new_location, pojazd_transform.rotation);
spectator.set_transform(transform);
control = py.carla.VehicleControl();
flaga = 0;
gaz = 1;
prawda = true;
indeks = 1;

pause(1);

while prawda 

v = pojazd.get_velocity(); 
s = 3.6 * sqrt(v.x^2 + v.y^2 + v.z^2);
predkosci(indeks) = s;

obecnyCzas = py.time.time();
czas(indeks) = obecnyCzas;

pit = pojazd.get_transform().rotation;
peach(indeks) = pit.pitch;



if flaga==0
    gaz(indeks) = 1;
    hamulec(indeks) = 0;
    control.throttle=1.0;
    control.brake=0.0;
end

if s >= 100
    flaga = 1;
end

if flaga==1
    gaz(indeks) = 0;
    hamulec(indeks) = 1;
    control.throttle=0.0;
    control.brake=1.0;
end

pojazd.apply_control(control);

if flaga == 1 && s <=0
    prawda = false;
end

indeks = indeks + 1;
end

czas(:) = czas(:)- czas(1);

figure
plot(czas,predkosci)
xlabel('Czas, s')
ylabel('Prędkość, km/h')

figure
plot(czas,peach)
xlabel('Czas, s')
ylabel('Pitch, stopnie')


figure
plot(czas,gaz)
hold on
plot(czas,hamulec)
ylabel('Wartość wcisnięcia gazu i hamulca')
xlabel('Czas, s')
legend('Gaz','Hamulec')
ylim([-1,2])
hold off
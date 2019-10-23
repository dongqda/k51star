package com.project.k51star.dto;

public class CarInfoDto {
	private int car_id;
	private String car_model;
	private String manufacturer;
	private String fuel;
	private Double kpl;
	
	public CarInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CarInfoDto(int car_id, String car_model, String manufacturer, String fuel, Double kpl) {
		super();
		this.car_id = car_id;
		this.car_model = car_model;
		this.manufacturer = manufacturer;
		this.fuel = fuel;
		this.kpl = kpl;
	}

	public int getCar_id() {
		return car_id;
	}
	public void setCar_id(int car_id) {
		this.car_id = car_id;
	}
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getFuel() {
		return fuel;
	}
	public void setFuel(String fuel) {
		this.fuel = fuel;
	}
	public Double getKpl() {
		return kpl;
	}
	public void setKpl(Double kpl) {
		this.kpl = kpl;
	}
	
	@Override
	public String toString() {
		return "CarInfoDto [car_id=" + car_id + ", car_model=" + car_model + ", manufacturer=" + manufacturer
				+ ", fuel=" + fuel + ", kpl=" + kpl + "]";
	}
	
}

using Godot;
using System;

public partial class CourseCrab : CharacterBody2D
{
	private int _defense;
	private int CrabVelocity;
	private int Integrity;
	private int Reaction;
	private double StunTimer;
	private float Speed = 50.0f;
	private Random random = new Random();
	private int Defense
	{
		get{ return _defense;}
		
		set
		{
			_defense = value;
			
			if(_defense <= 0){
				Death();
			}
		}
	}
	
	
	[Export] Area2D HitArea;
	
	[Signal] public delegate void CrabDefeatedEventHandler();
	

	public override void _Ready(){
		Node GlobalNode = GetNode("/root/Global");
		
		CrabVelocity = (int)GlobalNode.Get("velocity");
		Integrity = (int)GlobalNode.Get("integrity");
		Reaction = (int)GlobalNode.Get("reaction");
		Defense = (int)GlobalNode.Get("defense");
		
		HitArea.AreaEntered += OnAreaEntered;
		
	}
	
	
	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		// Add the gravity.
		if (!IsOnFloor())
		{
			velocity += GetGravity() * (float)delta;
		}
		if(StunTimer > 0){
			StunTimer -= delta;
		}
		
		if(StunTimer <= 0 ){
			velocity.X = CrabVelocity * Speed;
	
		}

		Velocity = velocity * CrabVelocity;
		MoveAndSlide();
	}

	private void OnAreaEntered(Area2D area){
		if(area.IsInGroup("Enemies")){
			if(area.Name == "HedgehogArea"){
				Defense -= 1;
			}
			else if(!Dodge()){
				Defense -= 1;
			}
			else{
				//Colocar animação de desvio
			}
			
		}
	}
	
	private void Death(){
		EmitSignal(SignalName.CrabDefeated);
		SetPhysicsProcess(false);
		GetNode<CollisionShape2D>("HitArea/CollisionShape2D").SetDeferred(CollisionShape2D.PropertyName.Disabled, true);
	}
	
	private bool Dodge(){
		double DodgeChance = random.NextDouble();
		
		if(DodgeChance <= 0.02 * Reaction){
			return true;
		}else{
			return false;
		}
	}
}

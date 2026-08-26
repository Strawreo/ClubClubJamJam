using Godot;
using System;

public partial class CourseCrab : CharacterBody2D
{
	private int _defense;
	private int CrabVelocity;
	private int Integrity;
	private int Reaction;
	private float StunTimer;
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
	[Export] private AnimatedSprite2D animation;
	
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
			velocity = Vector2.Zero;
			StunTimer -= (float)delta;
			animation.Stop();
		}
		
		if(StunTimer <= 0 ){
			animation.Animation = "default";
			velocity.X = CrabVelocity * Speed;
			animation.Play();
		}

		
		Velocity = velocity;
		MoveAndSlide();
	}

	private void OnAreaEntered(Area2D area){
		if(area.IsInGroup("Enemies")){
			if(area.Name == "HedgehogArea"){
				
			}
			else if(!Dodge()){
				
				if(area.Name == "NautilusHitArea"){
					
					StunTimer = 1.5f - (0.05f * Integrity);
				}
			}
			else{
				//Colocar animação de desvio
			}
			
		}
	}
	
	private async void Death(){
		EmitSignal(SignalName.CrabDefeated);
		SetPhysicsProcess(false);
		GetNode<CollisionShape2D>("HitArea/CollisionShape2D").SetDeferred(CollisionShape2D.PropertyName.Disabled, true);
		await ToSignal(GetTree().CreateTimer(2.0f), SceneTreeTimer.SignalName.Timeout);
		GetTree().ChangeSceneToFile("res://Scenes/Menu/Main.tscn");
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

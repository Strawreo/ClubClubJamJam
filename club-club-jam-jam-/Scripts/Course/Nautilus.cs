using Godot;
using System;

public partial class Nautilus : CharacterBody2D
{
	private const float Speed = 200.0f;
	private const float KnockbackSpeed = 150.0f;
	private const float KnockbackTime = 1.5f;
	private float KnockbackTimer = 0;
	private float StunTime = 1.0f;
	private float StunTimer;
	private CharacterBody2D hermit;
	private Vector2 direction;
	private bool DetectFlag;
	
	[Export] private Area2D DetectArea;
	[Export] private Area2D HitArea;

	
	public override void _Ready(){
		DetectArea.AreaEntered += OnDetectAreaEntered;
		DetectArea.AreaExited += OnDetectAreaExited;
		HitArea.BodyEntered += OnBodyEntered;
		hermit = GetParent().GetNode<CharacterBody2D>("CourseCrab");
		
	}


	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;
		direction = GlobalPosition.DirectionTo(hermit.GlobalPosition);
		
		
		if(KnockbackTimer >= 1.0){
			velocity = -direction * KnockbackSpeed;
			KnockbackTimer -= (float)delta;
			
			velocity = velocity.MoveToward(Vector2.Zero, 1000f * (float)delta);
		}
		else{
			LookAt(hermit.GlobalPosition);
			velocity = Vector2.Zero;
			KnockbackTimer -= (float)delta;
		}

		if(DetectFlag && KnockbackTimer <= 0){
			velocity = direction*Speed;
			
		}

		Velocity = velocity;
		MoveAndSlide();
	}

	private void OnDetectAreaEntered(Area2D area){
			DetectFlag = true;
	}
	
	private void OnDetectAreaExited(Area2D area){
		DetectFlag = false;
	}
	
	private void OnBodyEntered(Node2D body){
		KnockbackTimer = KnockbackTime;
	}

}

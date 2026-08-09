using Godot;
using System;

public partial class BubbleShot : Area2D
{
	private Vector2 direction;
	private float Speed = 0.6f;
	private Vector2 predict = new Vector2 (0.5f,0);
	
	[Export] private AnimatedSprite2D animation;
	
	
	
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		BodyEntered += OnBodyEntered;
		animation.AnimationFinished += OnAnimationFinished;
		animation.Animation = "Instantiate";
		animation.Play();
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		GlobalPosition += Speed * (direction + predict);
	}
	

	
	private void OnBodyEntered(Node2D body){
		QueueFree();
		
	}
	
	private void OnAnimationFinished(){
		if(animation.Animation == "Instantiate"){
			animation.Animation = "Following";
			animation.Play();
		}
	}
	
	public void Setup(Vector2 Direction){
		direction = Direction;
	}

}

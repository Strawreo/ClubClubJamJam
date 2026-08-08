using Godot;
using System;

public partial class Seahorse : CharacterBody2D
{
	[Export] private Area2D detectArea;
	[Export] private PackedScene BubbleShot;
	private BubbleShot shot;
	private CharacterBody2D hermit;
	private Vector2 Direction;
	private double Timer = 1.0;
	private double ActualTime;
	private bool DetectFlag;
	
	
	public override void _Ready(){
		detectArea.AreaEntered += OnAreaEntered;
		detectArea.AreaExited += OnAreaExited;
		hermit = GetParent().GetNode<CharacterBody2D>("CourseCrab");
	}

	public override void _PhysicsProcess(double delta)
	{
		Direction = GlobalPosition.DirectionTo(hermit.GlobalPosition);
		
		if(DetectFlag && ActualTime <= 0){
			Shoot();
			ActualTime = Timer;
		}
		
		if(ActualTime > 0){
			ActualTime -= delta;
		}
	
	
	}

	private void OnAreaEntered(Area2D area){
		DetectFlag = true;
	}

	private void OnAreaExited(Area2D area){
		DetectFlag = false;
	}
	private void Shoot(){
		shot = BubbleShot.Instantiate<BubbleShot>();
		AddChild(shot);
		shot.Setup(Direction);
	}
}

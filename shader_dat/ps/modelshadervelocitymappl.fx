float4 main(float4 color : COLOR) : COLOR
{
	float4 o;

	float4 r0;
	r0 = color.w;
	clip(r0);
	o = color;

	return o;
}

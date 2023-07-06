float4 g_MatrialColor;
sampler g_Sampler0;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color2 : COLOR2;
	float4 color1 : COLOR1;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = r0.w + -0.01;
	r0 = r0 * g_MatrialColor;
	clip(r1);
	o.color = r0;
	o.color2 = r0;
	o.color1 = i.texcoord1.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);

	return o;
}

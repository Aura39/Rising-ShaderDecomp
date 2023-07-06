sampler g_Sampler0;
sampler g_Sampler1;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xy = 0.001953125 + texcoord.xy;
	r1 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler0, r0);
	r0.x = r0.z + -0.5;
	r0.y = r1.z + -0.5;
	r0.x = r0.y * 0.0275 + r0.x;
	o.z = r0.x + 0.5;
	o.xyw = 0;

	return o;
}

sampler g_Sampler0 : register(s0);
float4 g_uvOffset : register(c185);

float4 main(float2 texcoord1 : TEXCOORD1) : COLOR
{
	float4 o;

	float4 r0;
	r0.xy = g_uvOffset.xy + texcoord1.xy;
	r0 = tex2D(g_Sampler0, r0);
	r0 = r0.w + -0.5;
	clip(r0);
	o = float4(0, 0, 0, 1);

	return o;
}

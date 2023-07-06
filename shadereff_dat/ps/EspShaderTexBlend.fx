float4 g_BlendRate;
sampler g_Sampler0;
sampler g_Sampler1;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, i.texcoord);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1 = r1 * i.texcoord1;
	r0 = r0 * i.texcoord1 + -r1;
	r0 = g_BlendRate.x * r0 + r1;
	r1 = r0.w + -0.001;
	o = r0;
	clip(r1);

	return o;
}

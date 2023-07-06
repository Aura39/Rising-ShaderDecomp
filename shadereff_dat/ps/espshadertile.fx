sampler g_Sampler0;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = r0.w * i.texcoord7.w + -0.001;
	r0 = r0 * i.texcoord7;
	o = r0;
	clip(r1);

	return o;
}

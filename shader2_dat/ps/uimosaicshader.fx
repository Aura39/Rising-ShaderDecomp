sampler g_Sampler0 : register(s13);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	r0.xy = i.texcoord2.xy;
	r0.xy = r0.xy * i.texcoord.xy;
	r0.zw = frac(r0.xy);
	r0.xy = -r0.zw + r0.xy;
	r0.zw = 0.5 * i.texcoord2.zw;
	r0.xy = r0.xy * i.texcoord2.zw + r0.zw;
	r0 = tex2D(g_Sampler0, r0);
	r0 = r0.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o = r0 * i.texcoord1;

	return o;
}

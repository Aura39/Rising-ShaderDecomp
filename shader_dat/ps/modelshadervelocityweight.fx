float4 g_BlurParam;
sampler g_Sampler0;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float r1;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0 = r0.w;
	clip(r0);
	r0.x = 1 / i.texcoord1.z;
	r0.xy = r0.xx * i.texcoord2.xy;
	r0.z = 1 / i.texcoord1.w;
	r0.xy = i.texcoord1.xy * r0.zz + -r0.xy;
	r1.x = 0.5;
	o.xy = r0.xy * g_BlurParam.xy + r1.xx;
	o.zw = float2(0.5, 0);

	return o;
}

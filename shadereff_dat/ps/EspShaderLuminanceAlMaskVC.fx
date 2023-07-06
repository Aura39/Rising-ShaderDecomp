float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = r0.w + -0.0001;
	clip(r1);
	r1.x = dot(r0.xyz, 0.298912);
	r1.x = r1.x * g_Rate.x;
	r1.yzw = r0.xyz * i.texcoord7.xyz;
	r0.xyz = r0.xyz * -i.texcoord7.xyz + r0.xyz;
	o.xyz = r1.xxx * r0.xyz + r1.yzw;
	r1 = tex2D(g_Sampler1, i.texcoord1);
	r0.x = r0.w * r1.w;
	o.w = r0.x * i.texcoord7.w;

	return o;
}
